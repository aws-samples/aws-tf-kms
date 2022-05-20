//---------------------------------------------------------//
// Provider Variable
//---------------------------------------------------------//
region = "us-east-1"

//---------------------------------------------------------//
// Common Variables
//---------------------------------------------------------//
project = "aws-tf-kms"
env_name = "dev"
tags = {
  Env     = "DEV"
  Project = "aws-tf-kms"
}

//---------------------------------------------------------//
// Bootstrap Variables
//---------------------------------------------------------//
s3_statebucket_name   = "aws-tf-kms-dev-terraform-state-bucket"
dynamo_locktable_name = "aws-tf-kms-dev-terraform-state-locktable"