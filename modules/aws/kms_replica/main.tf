resource "aws_kms_replica_key" "kms_key_replica" {
  for_each = var.replicas_to_create
  provider = aws.replica

  description             = "Multi-Region replica key for ${each.key} from ${var.primary_region}"
  primary_key_arn         = data.aws_kms_key.primary_cmk[each.key].arn
  deletion_window_in_days = var.deletion_window_in_days
  enabled                 = true
  policy                  = replace(each.value.policy, var.primary_region, var.replica_region)

  tags = merge(
    {
      Name = "${each.value.alias}-replica"
    },
    var.tags
  )
}

resource "aws_kms_alias" "kms_alias" {
  for_each = var.replicas_to_create
  provider = aws.replica

  name          = each.value.alias
  target_key_id = aws_kms_replica_key.kms_key_replica[each.key].key_id
}
