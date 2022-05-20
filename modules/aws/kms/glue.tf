variable "enable_kms_glue" {
  description = "Enable customer managed key that can be used to encrypt/decrypt AWS Glue"
  type        = bool
  default     = false
}
variable "enable_key_rotation_glue" {
  description = "Enable key rotation for AWS Glue CMK"
  type        = bool
  default     = true
}
variable "enable_multi_region_glue" {
  description = "Enable multi-region for AWS Glues CMK"
  type        = bool
  default     = false
}
variable "override_policy_glue" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "glue" {
  # checkov:skip=CKV_AWS_109: Not applicable, using condition
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access through Glue for all principals in the account that are authorized to use Glue"
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
        "glue.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = local.allowed_accounts_via_service
    }
  }

  # Is this access needed for cross-account? Owner account has *.* access
  # dynamic "statement" {
  #   for_each = local.enable_cross_account_access
  #   content {
  #     sid = "Allow direct access to key metadata to the cross-accounts"
  #     principals {
  #       type        = "AWS"
  #       identifiers = local.kms_cross_account_roots
  #     }
  #     actions = [
  #       "kms:Describe*",
  #       "kms:Get*",
  #       "kms:List*",
  #       "kms:RevokeGrant"
  #     ]
  #     resources = ["*"]
  #   }
  # }
}
