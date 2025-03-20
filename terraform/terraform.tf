terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "lambda-manager/terraform.tfstate"
    region         = "eu-west-2"
    use_lockfile   = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}
