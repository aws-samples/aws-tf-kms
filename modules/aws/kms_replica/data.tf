data "aws_kms_key" "primary_cmk" {
  for_each = var.replicas_to_create

  provider = aws.primary

  key_id = each.value.alias
}
