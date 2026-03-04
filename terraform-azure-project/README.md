# Terraform Azure Project

## Overview
This project is designed to provision and manage Azure resources using Terraform. It is structured to support multiple environments, specifically development and production, with reusable modules for Azure resources.

## Project Structure
```
terraform-azure-project
├── modules
│   └── azure
│       └── main.tf
├── environments
│   ├── dev
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   └── prod
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
└── README.md
```

## Prerequisites
- Terraform CLI installed (if not using Azure Cloud Shell)
- Azure CLI installed and configured
- An active Azure subscription

## Setup Instructions
1. **Install Terraform**: Follow the official [Terraform installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) to install Terraform on your local machine.

2. **Verify Installation**:
   - Run `terraform version` to check the installed version of Terraform.
   - Ensure that the Azure CLI is installed and authenticated by running `az login`.

3. **Configure Azure Provider**: Update the `providers.tf` file with your Azure credentials and any necessary configurations.

4. **Define Variables**: Modify the `variables.tf` files in both the `dev` and `prod` environments to specify the required input variables.

5. **Set Environment-Specific Values**: Update the `terraform.tfvars` files in both the `dev` and `prod` environments with the actual values for the variables.

## Usage
- To initialize the Terraform project, navigate to the desired environment directory (e.g., `environments/dev`) and run:
  ```
  terraform init
  ```

- To plan the deployment, execute:
  ```
  terraform plan
  ```

- To apply the changes and provision the resources, run:
  ```
  terraform apply
  ```

## Outputs
After applying the Terraform configuration, the outputs defined in `outputs.tf` will be displayed. This may include resource IDs, IP addresses, or other relevant information.

## Additional Information
Refer to the official Terraform documentation for more details on specific commands and configurations: [Terraform Documentation](https://www.terraform.io/docs/index.html).