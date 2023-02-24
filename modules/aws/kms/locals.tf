locals {
  kms_admin_roles              = [for role in data.aws_iam_role.kms_admin_role : role.arn]
  kms_usage_roles              = flatten([[for role in data.aws_iam_role.kms_usage_role : role.arn], local.kms_admin_roles, var.kms_usage_principal_arns])
  kms_cross_account_roots      = [for account_id in var.kms_usage_accounts : "arn:aws:iam::${account_id}:root"]
  enable_cross_account_access  = length(local.kms_cross_account_roots) > 0 ? ["true"] : []
  allowed_accounts_via_service = var.enable_cross_account_access_via_service ? flatten([[for account_id in var.kms_usage_accounts : account_id], [data.aws_caller_identity.current.account_id]]) : [data.aws_caller_identity.current.account_id]
}

locals {
  policies = {
    s3             = try(length(var.override_policy_s3), 0) == 0 ? data.aws_iam_policy_document.s3.json : var.override_policy_s3
    ebs            = try(length(var.override_policy_ebs), 0) == 0 ? data.aws_iam_policy_document.ebs.json : var.override_policy_ebs
    efs            = try(length(var.override_policy_efs), 0) == 0 ? data.aws_iam_policy_document.efs.json : var.override_policy_efs
    rds            = try(length(var.override_policy_rds), 0) == 0 ? data.aws_iam_policy_document.rds.json : var.override_policy_rds
    dynamodb       = try(length(var.override_policy_dynamodb), 0) == 0 ? data.aws_iam_policy_document.dynamodb.json : var.override_policy_dynamodb
    lambda         = try(length(var.override_policy_lambda), 0) == 0 ? data.aws_iam_policy_document.lambda.json : var.override_policy_lambda
    logs           = try(length(var.override_policy_logs), 0) == 0 ? data.aws_iam_policy_document.logs.json : var.override_policy_logs
    sns            = try(length(var.override_policy_sns), 0) == 0 ? data.aws_iam_policy_document.sns.json : var.override_policy_sns
    sqs            = try(length(var.override_policy_sqs), 0) == 0 ? data.aws_iam_policy_document.sqs.json : var.override_policy_sqs
    backup         = try(length(var.override_policy_backup), 0) == 0 ? data.aws_iam_policy_document.backup.json : var.override_policy_backup
    ssm            = try(length(var.override_policy_ssm), 0) == 0 ? data.aws_iam_policy_document.ssm.json : var.override_policy_ssm
    secretsmanager = try(length(var.override_policy_secretsmanager), 0) == 0 ? data.aws_iam_policy_document.secretsmanager.json : var.override_policy_secretsmanager
    session        = try(length(var.override_policy_session), 0) == 0 ? data.aws_iam_policy_document.session.json : var.override_policy_session
    kinesis        = try(length(var.override_policy_kinesis), 0) == 0 ? data.aws_iam_policy_document.kinesis.json : var.override_policy_kinesis
    glue           = try(length(var.override_policy_glue), 0) == 0 ? data.aws_iam_policy_document.glue.json : var.override_policy_glue
    acm            = try(length(var.override_policy_acm), 0) == 0 ? data.aws_iam_policy_document.acm.json : var.override_policy_acm
    mwaa           = try(length(var.override_policy_mwaa), 0) == 0 ? data.aws_iam_policy_document.mwaa.json : var.override_policy_mwaa
    ecr            = try(length(var.override_policy_ecr), 0) == 0 ? data.aws_iam_policy_document.ecr.json : var.override_policy_ecr
    eks            = try(length(var.override_policy_eks), 0) == 0 ? data.aws_iam_policy_document.eks.json : var.override_policy_eks
  }
  enable_key_rotation = {
    s3             = var.enable_key_rotation_s3
    ebs            = var.enable_key_rotation_ebs
    efs            = var.enable_key_rotation_efs
    rds            = var.enable_key_rotation_rds
    dynamodb       = var.enable_key_rotation_dynamodb
    lambda         = var.enable_key_rotation_lambda
    logs           = var.enable_key_rotation_logs
    sns            = var.enable_key_rotation_sns
    sqs            = var.enable_key_rotation_sqs
    backup         = var.enable_key_rotation_backup
    ssm            = var.enable_key_rotation_ssm
    secretsmanager = var.enable_key_rotation_secretsmanager
    session        = var.enable_key_rotation_session
    kinesis        = var.enable_key_rotation_kinesis
    glue           = var.enable_key_rotation_glue
    acm            = var.enable_key_rotation_acm
    mwaa           = var.enable_key_rotation_mwaa
    ecr            = var.enable_key_rotation_ecr
    eks            = var.enable_key_rotation_eks
  }
  multi_region = {
    s3             = var.enable_multi_region_s3
    ebs            = var.enable_multi_region_ebs
    efs            = var.enable_multi_region_efs
    rds            = var.enable_multi_region_rds
    dynamodb       = var.enable_multi_region_dynamodb
    lambda         = var.enable_multi_region_lambda
    logs           = var.enable_multi_region_logs
    sns            = var.enable_multi_region_sns
    sqs            = var.enable_multi_region_sqs
    backup         = var.enable_multi_region_backup
    ssm            = var.enable_multi_region_ssm
    secretsmanager = var.enable_multi_region_secretsmanager
    session        = var.enable_multi_region_session
    kinesis        = var.enable_multi_region_kinesis
    glue           = var.enable_multi_region_glue
    acm            = var.enable_multi_region_acm
    mwaa           = var.enable_multi_region_mwaa
    ecr            = var.enable_multi_region_ecr
    eks            = var.enable_multi_region_eks
  }
}

locals {
  keys_to_create = compact([
    var.enable_kms_s3 ? "s3" : "",
    var.enable_kms_ebs ? "ebs" : "",
    var.enable_kms_efs ? "efs" : "",
    var.enable_kms_rds ? "rds" : "",
    var.enable_kms_dynamodb ? "dynamodb" : "",
    var.enable_kms_lambda ? "lambda" : "",
    var.enable_kms_logs ? "logs" : "",
    var.enable_kms_sns ? "sns" : "",
    var.enable_kms_sqs ? "sqs" : "",
    var.enable_kms_backup ? "backup" : "",
    var.enable_kms_ssm ? "ssm" : "",
    var.enable_kms_secretsmanager ? "secretsmanager" : "",
    var.enable_kms_session ? "session" : "",
    var.enable_kms_kinesis ? "kinesis" : "",
    var.enable_kms_glue ? "glue" : "",
    var.enable_kms_acm ? "acm" : "",
    var.enable_kms_mwaa ? "mwaa" : "",
    var.enable_kms_ecr ? "ecr" : "",
    var.enable_kms_eks ? "eks" : ""
  ])
}
