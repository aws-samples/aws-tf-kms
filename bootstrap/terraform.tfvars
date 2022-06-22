/*---------------------------------------------------------
Provider Variable
---------------------------------------------------------*/
region = "us-east-1"

/*---------------------------------------------------------
Common Variables
---------------------------------------------------------*/
tags = {
  Env     = "DEV"
  Project = "aws-tf-kms"
}

/*---------------------------------------------------------
Bootstrap Variables
---------------------------------------------------------*/
s3_statebucket_name   = "aws-tf-kms-dev-terraform-state-bucket"
dynamo_locktable_name = "aws-tf-kms-dev-terraform-state-locktable"
