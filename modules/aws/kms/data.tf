data "aws_caller_identity" "current" {}

data "aws_iam_role" "kms_admin_role" {
  for_each = toset(var.kms_admin_roles)
  name     = each.value
}

data "aws_iam_role" "kms_usage_role" {
  for_each = toset(var.kms_usage_roles)
  name     = each.value
}

data "aws_iam_policy_document" "admin_kms_policy" {
  # checkov:skip=CKV_AWS_109: Not applicable
  # checkov:skip=CKV_AWS_111: Not applicable
  statement {
    sid = "Enable Owner account Root to have full access to the key"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "kms:*",
    ]
    resources = ["*"]
  }

  statement {
    sid = "Allow access for Key Administrators"
    principals {
      type        = "AWS"
      identifiers = local.kms_admin_roles
    }
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ]
    resources = ["*"]
  }

  statement {
    sid = "Allow granting of the key to Key Administrators"
    principals {
      type        = "AWS"
      identifiers = local.kms_admin_roles
    }
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]
    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = [true]
    }
  }

  dynamic "statement" {
    for_each = local.enable_cross_account_access
    content {
      sid = "Allow use of the key to the cross-account owners"
      principals {
        type        = "AWS"
        identifiers = local.kms_cross_account_roots
      }
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = local.enable_cross_account_access
    content {
      sid = "Allow granting of the key to the cross-account owners"
      principals {
        type        = "AWS"
        identifiers = local.kms_cross_account_roots
      }
      actions = [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ]
      resources = ["*"]
      condition {
        test     = "Bool"
        variable = "kms:GrantIsForAWSResource"
        values   = [true]
      }
    }
  }
}
