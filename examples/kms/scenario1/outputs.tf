output "kms_keys" {
  description = "KMS Keys created"
  value       = module.kms_keys.key_aliases
}
