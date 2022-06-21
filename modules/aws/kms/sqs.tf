variable "enable_kms_sqs" {
  description = "Enable customer managed key that can be used to encrypt/decrypt Amazon SQS"
  type        = bool
  default     = false
}
variable "enable_key_rotation_sqs" {
  description = "Enable key rotation for Amazon SQS CMK"
  type        = bool
  default     = true
}
variable "enable_multi_region_sqs" {
  description = "Enable multi-region for Amazon SQS CMK"
  type        = bool
  default     = false
}
variable "override_policy_sqs" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "sqs" {
  # checkov:skip=CKV_AWS_109: Not applicable, using condition
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access through Simple Queue Service (SQS) for all principals in the account that are authorized to use SQS"
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
        "sqs.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = local.allowed_accounts_via_service
    }
  }
  statement {
    sid = "Allow access to specific services"
    principals {
      type = "Service"
      identifiers = [
        "s3.amazonaws.com",
        "sns.amazonaws.com",
        "events.amazonaws.com"
      ]
    }
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*",
    ]
    resources = ["*"]
  }
}
