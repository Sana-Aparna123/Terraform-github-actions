terraform {
  required_version = "1.9.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0"
    }
  }
  backend "s3" {
    bucket         = "awsaparna123.xyz"
    key            = "terraformstatefile.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }

}

provider "aws" {
  # Configuration options
}