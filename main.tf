data "terraform_remote_state" "creds" {
  backend = "remote"
  config = {
    organization = "danpeacock"
    workspaces = {
      name = "Hargreaves-Lansdown-Vault-Admin"
    }
  }
}

data "vault_aws_access_credentials" "aws_creds" {
  backend = data.terraform_remote_state.creds.outputs.backend
  role    = data.terraform_remote_state.creds.outputs.role
}


data "vault_azure_access_credentials" "azure_creds" {
  backend = data.terraform_remote_state.creds.outputs.azure_backend
  role    = data.terraform_remote_state.creds.outputs.azure_role
}

provider "aws" {
  region     = var.region
  access_key = data.vault_aws_access_credentials.aws_creds.access_key
  secret_key = data.vault_aws_access_credentials.aws_creds.secret_key
}

provider "azurerm" {  
  features {
  }
  disable_terraform_partner_id = true
  version = "2.9"
  use_msal = true
  tenant_id         = var.azure_tenant_id
  subscription_id   = var.azure_subscription_id
  client_id         = data.vault_azure_access_credentials.azure_creds.client_id
  client_secret     = data.vault_azure_access_credentials.azure_creds.client_secret
}

# Create AWS EC2 Instance
resource "aws_instance" "main" {
  count = var.aws ? 1 : 0
  ami           = "ami-0e34bbddc66def5ac"
  instance_type = "t2.nano"
}

# Create Azure Instance
module "azure" {
  count = var.azure ? 1 : 0
  source = "./modules/azure"
  }