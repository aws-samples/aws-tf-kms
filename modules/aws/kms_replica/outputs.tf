output "key_aliases" {
  description = "KMS key replica aliases that are created"
  value       = { for k, v in var.replicas_to_create : k => aws_kms_alias.kms_alias[k].name }
}
