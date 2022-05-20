//---------------------------------------------------------//
// Provider Variable
//---------------------------------------------------------//
variable "region" {
  description = "The AWS Region e.g. us-east-1 for the environment"
  type        = string
}

//---------------------------------------------------------//
// Common Variables
//---------------------------------------------------------//
variable "project" {
  description = "Project name (prefix/suffix) to be used on all the resources identification"
  type        = string
}

variable "env_name" {
  description = "Environment name e.g. dev, prod"
  type        = string
}

variable "tags" {
  description = "Common and mandatory tags for the resources"
  type        = map(string)
}

//---------------------------------------------------------//
// Scenario Variables
//---------------------------------------------------------//
variable "kms_usage_principal_arns" {
  description = "List of cross-account principal ARNs"
  type        = list(string)
}

variable "kms_usage_accounts" {
  description = "List of trusted account Ids"
  type        = list(string)
}