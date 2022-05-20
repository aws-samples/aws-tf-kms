variable "enable_kms_ebs" {
  description = "Enable customer managed key that can be used to encrypt/decrypt Amazon EBS"
  type        = bool
  default     = false
}
variable "enable_key_rotation_ebs" {
  description = "Enable key rotation for Amazon EBS CMK"
  type        = bool
  default     = true
}
variable "enable_multi_region_ebs" {
  description = "Enable multi-region for Amazon EBS CMK"
  type        = bool
  default     = false
}
variable "override_policy_ebs" {
  description = "A valid KMS key policy JSON document. If not specified, a canonical key policy will be used."
  type        = string
  default     = null
}

data "aws_iam_policy_document" "ebs" {
  # checkov:skip=CKV_AWS_109: Not applicable, using condition
  # checkov:skip=CKV_AWS_111: Not applicable, using condition
  source_policy_documents = [data.aws_iam_policy_document.admin_kms_policy.json]

  statement {
    sid = "Allow access through EBS for all principals in the account that are authorized to use EBS"
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
        "ec2.${var.region}.amazonaws.com"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values = local.allowed_accounts_via_service
    }
  }
}