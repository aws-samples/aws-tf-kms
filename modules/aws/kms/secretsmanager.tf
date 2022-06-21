variable "enable_kms_secretsmanager" {
  description = "Enable customer managed key that can be used to encrypt/decrypt AWS Secrets Manager"
  type        = bool
  default     = false
}
variable "enable_key_rotation_secretsmanager" {
  description = "Enable key rotation for AWS Secrets Manager CMK"
  type        = bool
  default     = true
}
variable "enable_multi_region_secretsmanager" {
  description = "Enable multi-region for AWS Secrets Manager CMK"
  type        = bool
  default     = false
}
variable "override_policy_secretsmanager" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "secretsmanager" {
  # checkov:skip=CKV_AWS_109: Not applicable, using condition
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access through AWS Secrets Manager for all principals in the account that are authorized to use AWS Secrets Manager"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values = [
        "secretsmanager.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = local.allowed_accounts_via_service
    }
  }
}
