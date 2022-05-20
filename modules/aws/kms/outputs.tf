output "key_aliases" {
  description = "KMS key aliases that are created"
  value       = { for key in local.keys_to_create : key => aws_kms_alias.kms_alias[key].name }
}

output "key_policies" {
  description = "KMS key policies that are created"
  value       = { for key in local.keys_to_create : key => local.policies[key] }
}
