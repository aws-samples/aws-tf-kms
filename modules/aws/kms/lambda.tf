# tflint-ignore: terraform_standard_module_structure
variable "enable_kms_lambda" {
  description = "Enable customer managed key that can be used to encrypt/decrypt AWS Lambda"
  type        = bool
  default     = false
}

# tflint-ignore: terraform_standard_module_structure
variable "enable_key_rotation_lambda" {
  description = "Enable key rotation for AWS Lambda CMK"
  type        = bool
  default     = true
}

# tflint-ignore: terraform_standard_module_structure
variable "enable_multi_region_lambda" {
  description = "Enable multi-region for AWS Lambda CMK"
  type        = bool
  default     = false
}

# tflint-ignore: terraform_standard_module_structure
variable "override_policy_lambda" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "lambda" {
  # checkov:skip=CKV_AWS_109: Not applicable, using condition
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access through AWS Lambda for all principals in the account that are authorized to use AWS Lambda"
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
      "kms:DescribeKey"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values = [
        "lambda.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = local.allowed_accounts_via_service
    }
  }
}
