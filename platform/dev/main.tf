terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  #   backend "local" {} # temporary local backend
  backend "s3" {
    bucket  = "karoosoftware-backend-tf"
    key     = "karoosoftware/terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}




data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "my-terraform-state"
    key    = "network/dev/terraform.tfstate"
    region = "eu-west-2"
  }
}