# team2-tf

Terraform infrastructure for Team 2 deployment.

## Pipeline behavior

- Pull requests and non-main branches: `terraform plan` only
- Main branch pushes: `terraform plan` then `terraform apply`
- Runs in non-interactive mode (`-input=false`) for CI/CD
- Uses remote state via `azurerm` backend config values from GitHub secrets

## Environment convention

- Default pipeline environment is `dev`
- Default naming is set in `dev.auto.tfvars`
- `resource_group_name` is nullable so generated naming can be driven by variables

## Required GitHub secrets

Terraform/Azure auth:

- `CLIENT_ID`
- `CLIENT_SECRET`
- `SUBSCRIPTION_ID`
- `TENANT_ID`

Remote state backend:

- `TFSTATE_RESOURCE_GROUP`
- `TFSTATE_STORAGE_ACCOUNT`
- `TFSTATE_CONTAINER`
- `TFSTATE_KEY`
- `ARM_ACCESS_KEY`
