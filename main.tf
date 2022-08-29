data "terraform_remote_state" "creds" {
  backend = "remote"
  config = {
    organization = "danpeacock"
    workspaces = {
      name = "Hargreaves-Lansdown-Vault-Admin"
    }
  }
}

data "vault_aws_access_credentials" "creds" {
  backend = data.terraform_remote_state.creds.outputs.backend
  role    = data.terraform_remote_state.creds.outputs.role
}

provider "aws" {
  region     = var.region
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
}

# Create AWS EC2 Instance
resource "aws_instance" "main" {
  count = var.aws ? 1 : 0
  ami           = "ami-0e34bbddc66def5ac"
  instance_type = "t2.nano"
}