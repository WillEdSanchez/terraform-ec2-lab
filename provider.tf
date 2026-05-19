terraform {

  required_version = ">= 1.5"

  backend "s3" {
    bucket = "terraform-state-willians-2026"
    key    = "terraform-ec2-lab/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

provider "aws" {
  region = "us-east-1"
}