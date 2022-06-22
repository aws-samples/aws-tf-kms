/*---------------------------------------------------------
Provider Variable
---------------------------------------------------------*/
region = "us-east-1"

/*---------------------------------------------------------
Common Variables
---------------------------------------------------------*/
project = "scenario1-kms"

tags = {
  Env     = "DEV"
  Project = "scenario1-kms"
}

/*---------------------------------------------------------
 Scenario Variables
---------------------------------------------------------*/
kms_usage_principal_arns = [
  "arn:aws:iam::<your-trusted-account-id>:role/Admin"
]
kms_usage_accounts = [
  "<your-trusted-account-id>"
]
