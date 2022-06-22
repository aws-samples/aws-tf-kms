# tflint-ignore: terraform_standard_module_structure
variable "enable_kms_s3" {
  description = "Enable customer managed key that can be used to encrypt/decrypt Amazon S3"
  type        = bool
  default     = false
}

# tflint-ignore: terraform_standard_module_structure
variable "enable_key_rotation_s3" {
  description = "Enable key rotation for Amazon S3 CMK"
  type        = bool
  default     = true
}

# tflint-ignore: terraform_standard_module_structure
variable "enable_multi_region_s3" {
  description = "Enable multi-region for Amazon S3 CMK"
  type        = bool
  default     = false
}

# tflint-ignore: terraform_standard_module_structure
variable "override_policy_s3" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "s3" {
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access through S3 for all principals in the account that are authorized to use S3"
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
        "s3.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = local.allowed_accounts_via_service
    }
  }
}
