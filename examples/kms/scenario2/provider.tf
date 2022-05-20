terraform {
  required_version = ">= v1.1.9"

  # Set minimum required versions for providers using lazy matching
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.13.0"
    }
  }

  # Configure the S3 backend
  backend "s3" {
    encrypt        = true
    region         = "us-east-1"
    bucket         = "aws-tf-kms-dev-terraform-state-bucket"
    dynamodb_table = "aws-tf-kms-dev-terraform-state-locktable"
    key            = "aws-tf-kms/kms/scenario2/terraform.tfstate"
  }
}

# Configure the AWS Provider to assume_role and set default region
provider "aws" {
  region = var.region
}

provider "aws" {
  region = "us-east-2"
  alias  = "use2"
}

provider "aws" {
  region = "us-west-1"
  alias  = "usw1"
}

provider "aws" {
  region = "us-west-2"
  alias  = "usw2"
}
