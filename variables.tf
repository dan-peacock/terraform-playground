variable "name" { 
    default = "dynamic-aws-creds-operator" 
    }
variable "region" { 
    default = "us-east-1" 
    }
variable "path" {
     default = "../vault-admin-workspace/terraform.tfstate" 
     }
variable "ttl" { 
    default = "1" 
    }

variable "aws" {
    default = "false"
    type = bool
}

variable "azure" {
    default = "false"
    type = bool
}