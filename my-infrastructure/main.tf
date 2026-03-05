module "resource_group" {
  source = "../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = var.environment
  }
}

data "azurerm_client_config" "current" {}

# Compute ACR login server without data source (avoids listCredentials permission)
locals {
  acr_login_server = "${var.acr_name}.azurecr.io"
  backend_app_name    = "ca-team2-backend-dev"
  backend_target_port  = 8080
  frontend_app_name   = "ca-team2-frontend-dev"
  frontend_target_port = 80
  acr_image1 = "team2-front-app"
  acr_image2 = "team2-back-app"
  acr_image1_tag        = "latest"
  acr_image2_tag        = "latest"
  acr_image1_repo       = "${local.acr_login_server}/${local.acr_image1}:${local.acr_image1_tag}"
  acr_image2_repo       = "${local.acr_login_server}/${local.acr_image2}:${local.acr_image2_tag}"
}

resource "azurerm_key_vault" "main" {
  name                       = var.key_vault_name
  location                   = module.resource_group.location
  resource_group_name        = module.resource_group.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  enable_rbac_authorization  = true
  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  tags = {
    environment = var.environment
  }
}

resource "azurerm_user_assigned_identity" "container_apps" {
  name                = var.container_apps_identity_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  tags = {
    environment = var.environment
  }
}

resource "azurerm_container_app_environment" "main" {
  name                       = var.container_app_environment_name
  location                   = module.resource_group.location
  resource_group_name        = module.resource_group.name

  tags = {
    environment = var.environment
  }
}

# RBAC: Grant managed identity AcrPull on ACR
resource "azurerm_role_assignment" "acr_pull" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.acr_resource_group_name}/providers/Microsoft.ContainerRegistry/registries/${var.acr_name}"
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.container_apps.principal_id
  principal_type       = "ServicePrincipal"
}

# RBAC: Grant managed identity Key Vault Secrets User on Key Vault
resource "azurerm_role_assignment" "keyvault_secrets_user" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.container_apps.principal_id
  principal_type       = "ServicePrincipal"
}

# Frontend Container App (external ingress enabled)
module "frontend_app" {
  source = "../modules/container-app"

  name                         = local.frontend_app_name
  resource_group_name          = module.resource_group.name
  container_app_environment_id = azurerm_container_app_environment.main.id
  managed_identity_id          = azurerm_user_assigned_identity.container_apps.id
  registry_server              = local.acr_login_server
  container_name               = "frontend"
  image_repo                   = local.acr_image1_repo
  image_tag                    = local.acr_image1_tag
  cpu                          = 0.5
  memory                       = "1Gi"
  enable_ingress               = true
  external_enabled             = true
  target_port                  = local.frontend_target_port

  # Feature flag example - plain text env vars for easy toggling
  env_vars = [
    {
      name  = "ENABLE_FEATURE_X"
      value = "true"
    },
    {
      name  = "ENVIRONMENT"
      value = var.environment
    },
    {
    name  = "API_BASE_URL"
    value = module.backend_app.fqdn  # e.g., https://ca-team2-backend-dev--xxx.internal.managosea...
    },
    {
      name  = "CURRENT_HOST"
      value = "${var.frontend_app_name}.${azurerm_container_app_environment.main.default_domain}"
    },
  ]

  # Key Vault secret references (manually add secrets in portal first)
  # Example: session-secret references Key Vault secret "SessionSecret"
  keyvault_secrets = [
    {
      name                = "port-secret"
      key_vault_secret_id = "${azurerm_key_vault.main.vault_uri}secrets/PORT/b0953857b8294f0dacf1c02b3c6b543d"
    },
    {
      name                = "jwt-secret"
      key_vault_secret_id = "${azurerm_key_vault.main.vault_uri}secrets/JWTSECRET/c9edfb806c3d418ab230f4121c4c7c9a"
    }
  ]

  # Uncomment to use Key Vault secrets in env:
  secret_env_vars = [
    {
      name        = "PORT"
      secret_name = "port-secret"
    },
    {
      name       = "JWT_SECRET"
      secret_name = "jwt-secret"
    }
  ]

  tags = {
    environment = var.environment
    app         = "frontend"
  }

  depends_on = [
    azurerm_role_assignment.acr_pull,
    azurerm_role_assignment.keyvault_secrets_user
  ]
}

# Backend Container App (internal ingress only)
module "backend_app" {
  source = "../modules/container-app"

  name                         = local.backend_app_name
  resource_group_name          = module.resource_group.name
  container_app_environment_id = azurerm_container_app_environment.main.id
  managed_identity_id          = azurerm_user_assigned_identity.container_apps.id
  registry_server              = local.acr_login_server
  container_name               = "backend"
  image_repo                   = local.acr_image2_repo
  image_tag                    = local.acr_image2_tag
  cpu                          = 0.5
  memory                       = "1Gi"
  enable_ingress               = true
  external_enabled             = false  # Internal only
  target_port                  = local.backend_target_port

  # Feature flag and app config
  env_vars = [
    {
      name  = "ENABLE_FEATURE_Y"
      value = "false"
    },
    {
      name  = "ENVIRONMENT"
      value = var.environment
    },
    {
      name  = "SCHEMA_NAME"
      value = "job_roles_db"
    },
    {
      name  = "JWT_EXPIRES_IN"
      value = "1h"
    },
    {
      name  = "S3_BUCKET_NAME"
      value = "team-2-bucket-067502745215"
    },
    {
      name  = "AWS_REGION"
      value = "us-east-1"
    },
    {
      name = "DATABASE_URL"
      value = "postgresql://sam@localhost:5432/postgres?schema=job_roles_db"
    },
    {
      name = "PORT"
      value = local.backend_target_port
    }
  ]

  # Key Vault secrets
  keyvault_secrets = [
    {
      name                = "jwt-secret"
      key_vault_secret_id = "${azurerm_key_vault.main.vault_uri}secrets/JWTSECRET/c9edfb806c3d418ab230f4121c4c7c9a"
    },
    {
      name                = "aws-access-key"
      key_vault_secret_id = "https://kvteam2devsam20260304.vault.azure.net/secrets/AWSACCESSKEYID/e84114df2bb04d6fae36f486a560b82d"
    },
    {
      name                = "aws-secret-key"
      key_vault_secret_id = "https://kvteam2devsam20260304.vault.azure.net/secrets/AWSSECRETACCESSKEY/4828aee657854d50954ddaa165deb330"
    }
  ]

  secret_env_vars = [
    {
      name        = "JWT_SECRET"
      secret_name = "jwt-secret"
    },
    {
      name        = "AWS_ACCESS_KEY_ID"
      secret_name = "aws-access-key"
    },
    {
      name        = "AWS_SECRET_ACCESS_KEY"
      secret_name = "aws-secret-key"
    }
  ]

  tags = {
    environment = var.environment
    app         = "backend"
  }

  depends_on = [
    azurerm_role_assignment.acr_pull,
    azurerm_role_assignment.keyvault_secrets_user
  ]
}
