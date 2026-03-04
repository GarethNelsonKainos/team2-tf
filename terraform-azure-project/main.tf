# terraform-azure-project/main.tf

module "resource_group" {
  source   = "./modules/resource-group"
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = "kainos-academy"
  }
}