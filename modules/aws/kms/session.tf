variable "enable_kms_session" {
  description = "Enable customer managed key that can be used to encrypt/decrypt AWS Systems Manager Session Manager"
  type        = bool
  default     = false
}
variable "enable_key_rotation_session" {
  description = "Enable key rotation for AWS Systems Manager Session Manager CMK"
  type        = bool
  default     = true
}
variable "enable_multi_region_session" {
  description = "Enable multi-region for AWS Systems Manager Session Manager CMK"
  type        = bool
  default     = false
}
variable "override_policy_session" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "session" {
  # checkov:skip=CKV_AWS_111: Not applicable
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow use of the key"
    principals {
      type        = "AWS"
      identifiers = local.kms_usage_roles
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }
}
