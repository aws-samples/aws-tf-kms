# tflint-ignore: terraform_standard_module_structure
variable "enable_kms_kinesis" {
  description = "Enable customer managed key that can be used to encrypt/decrypt Amazon Kinesis"
  type        = bool
  default     = false
}

# tflint-ignore: terraform_standard_module_structure
variable "enable_key_rotation_kinesis" {
  description = "Enable key rotation for Amazon Kinesis CMK"
  type        = bool
  default     = true
}

# tflint-ignore: terraform_standard_module_structure
variable "enable_multi_region_kinesis" {
  description = "Enable multi-region for Amazon Kinesis CMK"
  type        = bool
  default     = false
}

# tflint-ignore: terraform_standard_module_structure
variable "override_policy_kinesis" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "kinesis" {
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access through Amazon Kinesis for all principals in the account that are authorized to use Amazon Kinesis"
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
        "lambda.${var.region}.amazonaws.com",
        "kinesis.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = local.allowed_accounts_via_service
    }
  }
}
