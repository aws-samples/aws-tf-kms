variable "enable_kms_rds" {
  description = "Enable customer managed key that can be used to encrypt/decrypt Amazon RDS"
  type        = bool
  default     = false
}
variable "enable_key_rotation_rds" {
  description = "Enable key rotation for Amazon RDS CMK"
  type        = bool
  default     = true
}
variable "enable_multi_region_rds" {
  description = "Enable multi-region for Amazon RDS CMK"
  type        = bool
  default     = false
}
variable "override_policy_rds" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "rds" {
  # checkov:skip=CKV_AWS_109: Not applicable, using condition
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access through RDS for all principals in the account that are authorized to use RDS"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values = [
        "rds.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = local.allowed_accounts_via_service
    }
  }
}
