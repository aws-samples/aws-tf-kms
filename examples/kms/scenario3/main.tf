module "kms_keys" {
  source = "../../../modules/aws/kms"

  region = var.region

  project  = var.project
  env_name = var.env_name

  tags = var.tags

  kms_alias_prefix = var.project
  kms_admin_roles  = ["Admin"]
  kms_usage_roles  = ["Terraformer"]

  kms_usage_principal_arns = var.kms_usage_principal_arns
  kms_usage_accounts       = var.kms_usage_accounts

  enable_cross_account_access_via_service = true

  # enable_kms_s3             = true
  # enable_kms_ebs            = true
  # enable_kms_efs            = true
  # enable_kms_rds            = true
  # enable_kms_lambda         = true
  # enable_kms_logs           = true
  # enable_kms_sns            = true
  # enable_kms_sqs            = true
  # enable_kms_backup         = true
  # enable_kms_ssm            = true
  enable_kms_secretsmanager = true
  enable_kms_session        = true
  # enable_kms_kinesis = true
  # enable_kms_glue    = true
  # enable_kms_acm     = true

}

output "kms_keys" {
  description = "KMS Keys created"
  value       = module.kms_keys.key_aliases
}
