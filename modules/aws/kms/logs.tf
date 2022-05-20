variable "enable_kms_logs" {
  description = "Enable customer managed key that can be used to encrypt/decrypt Amazon CloudWatch Log"
  type        = bool
  default     = false
}
variable "enable_key_rotation_logs" {
  description = "Enable key rotation for Amazon CloudWatch Log CMK"
  type        = bool
  default     = true
}
variable "enable_multi_region_logs" {
  description = "Enable multi-region for Amazon CloudWatch Log CMK"
  type        = bool
  default     = false
}
variable "override_policy_logs" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "logs" {
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access to CloudWatch Logs"
    principals {
      type        = "Service"
      identifiers = ["logs.${var.region}.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]
    condition {
      test     = "ArnEquals"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values = [
        "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"
      ]
    }
  }
}
