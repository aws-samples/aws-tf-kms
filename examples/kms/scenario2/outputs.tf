output "kms_keys" {
  description = "KMS Keys created"
  value       = module.kms_keys.key_aliases
}

output "kms_replicas_use2" {
  description = "KMS Key replicas created in us-east-2"
  value       = module.kms_key_replicas_use2.key_aliases
}

output "kms_replicas_usw1" {
  description = "KMS Key replicas created in us-west-1"
  value       = module.kms_key_replicas_usw1.key_aliases
}

output "kms_replicas_usw2" {
  description = "KMS Key replicas created in us-west-2"
  value       = module.kms_key_replicas_usw2.key_aliases
}
