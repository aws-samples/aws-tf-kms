variable "enable_kms_dynamodb" {
  description = "Enable customer managed key that can be used to encrypt/decrypt Amazon DynamoDB"
  type        = bool
  default     = false
}
variable "enable_key_rotation_dynamodb" {
  description = "Enable key rotation for Amazon DynamoDB CMK"
  type        = bool
  default     = true
}
variable "enable_multi_region_dynamodb" {
  description = "Enable multi-region for Amazon DynamoDB CMK"
  type        = bool
  default     = false
}
variable "override_policy_dynamodb" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "dynamodb" {
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access through Amazon DynamoDB for all principals in the account that are authorized to use Amazon DynamoDB"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:CreateGrant"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values = [
        "dynamodb.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = local.allowed_accounts_via_service
    }
  }

  statement {
    sid = "Allow Amazon DynamoDB to directly describe the key"
    principals {
      type        = "Service"
      identifiers = ["dynamodb.amazonaws.com"]
    }
    actions = [
      "kms:Describe*",
      "kms:Get*",
      "kms:List*"
    ]
    resources = ["*"]
  }
}
