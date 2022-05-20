variable "enable_kms_ssm" {
  description = "Enable customer managed key that can be used to encrypt/decrypt AWS Systems Manager Parameter Store"
  type        = bool
  default     = false
}
variable "enable_key_rotation_ssm" {
  description = "Enable key rotation for AWS Systems Manager Parameter Store CMK"
  type        = bool
  default     = true
}
variable "enable_multi_region_ssm" {
  description = "Enable multi-region for AWS Systems Manager Parameter Store CMK"
  type        = bool
  default     = false
}
variable "override_policy_ssm" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "ssm" {
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access through SSM for all principals in the account that are authorized to use SSM"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values = [
        "ssm.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values = local.allowed_accounts_via_service
    }
  }
}
