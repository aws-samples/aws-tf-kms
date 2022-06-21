module "kms_keys" {
  source = "../../../modules/aws/kms"

  region = var.region

  project  = var.project
  env_name = var.env_name

  tags = var.tags

  kms_alias_prefix = var.project
  kms_admin_roles  = ["Admin"]
  kms_usage_roles  = []

  enable_kms_ebs          = true
  enable_multi_region_ebs = true
}

module "kms_key_replicas_use2" {
  source = "../../../modules/aws/kms_replica"
  providers = {
    aws.primary = aws
    aws.replica = aws.use2
  }

  primary_region = var.region
  replica_region = "us-east-2"

  project  = var.project
  env_name = var.env_name

  tags = var.tags

  replicas_to_create = {
    "ebs" = {
      "alias"  = module.kms_keys.key_aliases["ebs"]
      "policy" = module.kms_keys.key_policies["ebs"]
    }
  }

  depends_on = [
    module.kms_keys
  ]
}

module "kms_key_replicas_usw1" {
  source = "../../../modules/aws/kms_replica"
  providers = {
    aws.primary = aws
    aws.replica = aws.usw1
  }

  primary_region = var.region
  replica_region = "us-west-1"

  project  = var.project
  env_name = var.env_name

  tags = var.tags

  replicas_to_create = {
    "ebs" = {
      "alias"  = module.kms_keys.key_aliases["ebs"]
      "policy" = module.kms_keys.key_policies["ebs"]
    }
  }

  depends_on = [
    module.kms_keys
  ]
}

module "kms_key_replicas_usw2" {
  source = "../../../modules/aws/kms_replica"
  providers = {
    aws.primary = aws
    aws.replica = aws.usw2
  }

  primary_region = var.region
  replica_region = "us-west-2"

  project  = var.project
  env_name = var.env_name

  tags = var.tags

  replicas_to_create = {
    "ebs" = {
      "alias"  = module.kms_keys.key_aliases["ebs"]
      "policy" = module.kms_keys.key_policies["ebs"]
    }
  }

  depends_on = [
    module.kms_keys
  ]
}

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
