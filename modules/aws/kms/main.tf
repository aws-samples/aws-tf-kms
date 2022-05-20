resource "aws_kms_key" "kms_key" {
  # checkov:skip=CKV_AWS_7: Rotation is usage driven
  for_each                 = toset(local.keys_to_create)
  description              = "KMS key for encrypting ${each.value}"
  deletion_window_in_days  = var.deletion_window_in_days
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = local.policies[each.value]
  is_enabled               = true
  enable_key_rotation      = local.enable_key_rotation[each.value]
  multi_region             = local.multi_region[each.value]

  tags = merge(
    {
      Name = "${var.kms_alias_prefix}-${each.value}-cmk"
    },
    var.tags
  )
}

resource "aws_kms_alias" "kms_alias" {
  for_each = toset(local.keys_to_create)

  name          = "alias/${var.kms_alias_prefix}/${each.value}"
  target_key_id = aws_kms_key.kms_key[each.value].key_id
}

# resource "aws_kms_replica_key" "replica" {
#   description             = "Multi-Region replica key"
#   deletion_window_in_days = 7
#   primary_key_arn         = aws_kms_key.primary.arn
# }