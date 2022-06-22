/*---------------------------------------------------------
Provider Variable
---------------------------------------------------------*/
variable "region" {
  description = "The AWS Region e.g. us-east-1 for the environment"
  type        = string
}

/*---------------------------------------------------------
Common Variables
---------------------------------------------------------*/
variable "tags" {
  description = "Common and mandatory tags for the resources"
  type        = map(string)
  default     = {}
}

/*---------------------------------------------------------
KMS Variables
---------------------------------------------------------*/
variable "kms_alias_prefix" {
  description = "Prefix used in creating KMS alias using the pattern `alias/{prefix}/{key_name}'"
  type        = string
}

variable "kms_admin_roles" {
  description = "Provide at least one IAM role that has Admin access to the KMS keys"
  type        = list(string)
}

variable "kms_usage_roles" {
  description = "Zero or more IAM roles in the primary account that need usage access to the KMS keys"
  type        = list(string)
  default     = []
}

variable "kms_usage_principal_arns" {
  description = "Zero or more IAM roles ARNs that need usage access to the KMS keys, use this to allow access to cross-account principals"
  type        = list(string)
  default     = []
}

variable "kms_usage_accounts" {
  description = "Zero or more AWS Account IDs that need usage access to the KMS keys. The cross-acccount admin must provide IAM policies to enable access."
  type        = list(string)
  default     = []
}
variable "enable_cross_account_access_via_service" {
  description = "When 'kms_usage_accounts' are specified, enabling this flag allows cross-account access to the key via services e.g. S3, EBS, EFS"
  type        = bool
  default     = false
}

variable "deletion_window_in_days" {
  description = "The waiting period, after which the AWS KMS deletes the KMS key. It must be between 7 and 30. Default is 7."
  type        = number
  default     = 7
}
