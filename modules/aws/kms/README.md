<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= v1.1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_admin_roles"></a> [kms\_admin\_roles](#input\_kms\_admin\_roles) | Provide at least one IAM role that has Admin access to the KMS keys | `list(string)` | n/a | yes |
| <a name="input_kms_alias_prefix"></a> [kms\_alias\_prefix](#input\_kms\_alias\_prefix) | Prefix used in creating KMS alias using the pattern `alias/{prefix}/{key_name}'` | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS Region e.g. us-east-1 for the environment | `string` | n/a | yes |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | The waiting period, after which the AWS KMS deletes the KMS key. It must be between 7 and 30. Default is 7. | `number` | `7` | no |
| <a name="input_enable_cross_account_access_via_service"></a> [enable\_cross\_account\_access\_via\_service](#input\_enable\_cross\_account\_access\_via\_service) | When 'kms\_usage\_accounts' are specified, enabling this flag allows cross-account access to the key via services e.g. S3, EBS, EFS | `bool` | `false` | no |
| <a name="input_enable_key_rotation_acm"></a> [enable\_key\_rotation\_acm](#input\_enable\_key\_rotation\_acm) | Enable key rotation for AWS ACM CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_backup"></a> [enable\_key\_rotation\_backup](#input\_enable\_key\_rotation\_backup) | Enable key rotation for AWS Backup CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_dynamodb"></a> [enable\_key\_rotation\_dynamodb](#input\_enable\_key\_rotation\_dynamodb) | Enable key rotation for Amazon DynamoDB CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_ebs"></a> [enable\_key\_rotation\_ebs](#input\_enable\_key\_rotation\_ebs) | Enable key rotation for Amazon EBS CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_efs"></a> [enable\_key\_rotation\_efs](#input\_enable\_key\_rotation\_efs) | Enable key rotation for Amazon EFS CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_glue"></a> [enable\_key\_rotation\_glue](#input\_enable\_key\_rotation\_glue) | Enable key rotation for AWS Glue CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_kinesis"></a> [enable\_key\_rotation\_kinesis](#input\_enable\_key\_rotation\_kinesis) | Enable key rotation for Amazon Kinesis CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_lambda"></a> [enable\_key\_rotation\_lambda](#input\_enable\_key\_rotation\_lambda) | Enable key rotation for AWS Lambda CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_logs"></a> [enable\_key\_rotation\_logs](#input\_enable\_key\_rotation\_logs) | Enable key rotation for Amazon CloudWatch Log CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_rds"></a> [enable\_key\_rotation\_rds](#input\_enable\_key\_rotation\_rds) | Enable key rotation for Amazon RDS CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_s3"></a> [enable\_key\_rotation\_s3](#input\_enable\_key\_rotation\_s3) | Enable key rotation for Amazon S3 CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_secretsmanager"></a> [enable\_key\_rotation\_secretsmanager](#input\_enable\_key\_rotation\_secretsmanager) | Enable key rotation for AWS Secrets Manager CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_session"></a> [enable\_key\_rotation\_session](#input\_enable\_key\_rotation\_session) | Enable key rotation for AWS Systems Manager Session Manager CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_sns"></a> [enable\_key\_rotation\_sns](#input\_enable\_key\_rotation\_sns) | Enable key rotation for Amazon SNS CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_sqs"></a> [enable\_key\_rotation\_sqs](#input\_enable\_key\_rotation\_sqs) | Enable key rotation for Amazon SQS CMK | `bool` | `true` | no |
| <a name="input_enable_key_rotation_ssm"></a> [enable\_key\_rotation\_ssm](#input\_enable\_key\_rotation\_ssm) | Enable key rotation for AWS Systems Manager Parameter Store CMK | `bool` | `true` | no |
| <a name="input_enable_kms_acm"></a> [enable\_kms\_acm](#input\_enable\_kms\_acm) | Enable customer managed key that can be used to encrypt/decrypt AWS ACM | `bool` | `false` | no |
| <a name="input_enable_kms_backup"></a> [enable\_kms\_backup](#input\_enable\_kms\_backup) | Enable customer managed key that can be used to encrypt/decrypt AWS Backup | `bool` | `false` | no |
| <a name="input_enable_kms_dynamodb"></a> [enable\_kms\_dynamodb](#input\_enable\_kms\_dynamodb) | Enable customer managed key that can be used to encrypt/decrypt Amazon DynamoDB | `bool` | `false` | no |
| <a name="input_enable_kms_ebs"></a> [enable\_kms\_ebs](#input\_enable\_kms\_ebs) | Enable customer managed key that can be used to encrypt/decrypt Amazon EBS | `bool` | `false` | no |
| <a name="input_enable_kms_efs"></a> [enable\_kms\_efs](#input\_enable\_kms\_efs) | Enable customer managed key that can be used to encrypt/decrypt Amazon EFS | `bool` | `false` | no |
| <a name="input_enable_kms_glue"></a> [enable\_kms\_glue](#input\_enable\_kms\_glue) | Enable customer managed key that can be used to encrypt/decrypt AWS Glue | `bool` | `false` | no |
| <a name="input_enable_kms_kinesis"></a> [enable\_kms\_kinesis](#input\_enable\_kms\_kinesis) | Enable customer managed key that can be used to encrypt/decrypt Amazon Kinesis | `bool` | `false` | no |
| <a name="input_enable_kms_lambda"></a> [enable\_kms\_lambda](#input\_enable\_kms\_lambda) | Enable customer managed key that can be used to encrypt/decrypt AWS Lambda | `bool` | `false` | no |
| <a name="input_enable_kms_logs"></a> [enable\_kms\_logs](#input\_enable\_kms\_logs) | Enable customer managed key that can be used to encrypt/decrypt Amazon CloudWatch Log | `bool` | `false` | no |
| <a name="input_enable_kms_rds"></a> [enable\_kms\_rds](#input\_enable\_kms\_rds) | Enable customer managed key that can be used to encrypt/decrypt Amazon RDS | `bool` | `false` | no |
| <a name="input_enable_kms_s3"></a> [enable\_kms\_s3](#input\_enable\_kms\_s3) | Enable customer managed key that can be used to encrypt/decrypt Amazon S3 | `bool` | `false` | no |
| <a name="input_enable_kms_secretsmanager"></a> [enable\_kms\_secretsmanager](#input\_enable\_kms\_secretsmanager) | Enable customer managed key that can be used to encrypt/decrypt AWS Secrets Manager | `bool` | `false` | no |
| <a name="input_enable_kms_session"></a> [enable\_kms\_session](#input\_enable\_kms\_session) | Enable customer managed key that can be used to encrypt/decrypt AWS Systems Manager Session Manager | `bool` | `false` | no |
| <a name="input_enable_kms_sns"></a> [enable\_kms\_sns](#input\_enable\_kms\_sns) | Enable customer managed key that can be used to encrypt/decrypt Amazon SNS | `bool` | `false` | no |
| <a name="input_enable_kms_sqs"></a> [enable\_kms\_sqs](#input\_enable\_kms\_sqs) | Enable customer managed key that can be used to encrypt/decrypt Amazon SQS | `bool` | `false` | no |
| <a name="input_enable_kms_ssm"></a> [enable\_kms\_ssm](#input\_enable\_kms\_ssm) | Enable customer managed key that can be used to encrypt/decrypt AWS Systems Manager Parameter Store | `bool` | `false` | no |
| <a name="input_enable_multi_region_acm"></a> [enable\_multi\_region\_acm](#input\_enable\_multi\_region\_acm) | Enable multi-region for AWS ACM CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_backup"></a> [enable\_multi\_region\_backup](#input\_enable\_multi\_region\_backup) | Enable multi-region for AWS Backup CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_dynamodb"></a> [enable\_multi\_region\_dynamodb](#input\_enable\_multi\_region\_dynamodb) | Enable multi-region for Amazon DynamoDB CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_ebs"></a> [enable\_multi\_region\_ebs](#input\_enable\_multi\_region\_ebs) | Enable multi-region for Amazon EBS CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_efs"></a> [enable\_multi\_region\_efs](#input\_enable\_multi\_region\_efs) | Enable multi-region for Amazon EFS CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_glue"></a> [enable\_multi\_region\_glue](#input\_enable\_multi\_region\_glue) | Enable multi-region for AWS Glues CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_kinesis"></a> [enable\_multi\_region\_kinesis](#input\_enable\_multi\_region\_kinesis) | Enable multi-region for Amazon Kinesis CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_lambda"></a> [enable\_multi\_region\_lambda](#input\_enable\_multi\_region\_lambda) | Enable multi-region for AWS Lambda CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_logs"></a> [enable\_multi\_region\_logs](#input\_enable\_multi\_region\_logs) | Enable multi-region for Amazon CloudWatch Log CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_rds"></a> [enable\_multi\_region\_rds](#input\_enable\_multi\_region\_rds) | Enable multi-region for Amazon RDS CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_s3"></a> [enable\_multi\_region\_s3](#input\_enable\_multi\_region\_s3) | Enable multi-region for Amazon S3 CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_secretsmanager"></a> [enable\_multi\_region\_secretsmanager](#input\_enable\_multi\_region\_secretsmanager) | Enable multi-region for AWS Secrets Manager CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_session"></a> [enable\_multi\_region\_session](#input\_enable\_multi\_region\_session) | Enable multi-region for AWS Systems Manager Session Manager CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_sns"></a> [enable\_multi\_region\_sns](#input\_enable\_multi\_region\_sns) | Enable multi-region for Amazon SNS CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_sqs"></a> [enable\_multi\_region\_sqs](#input\_enable\_multi\_region\_sqs) | Enable multi-region for Amazon SQS CMK | `bool` | `false` | no |
| <a name="input_enable_multi_region_ssm"></a> [enable\_multi\_region\_ssm](#input\_enable\_multi\_region\_ssm) | Enable multi-region for AWS Systems Manager Parameter Store CMK | `bool` | `false` | no |
| <a name="input_kms_usage_accounts"></a> [kms\_usage\_accounts](#input\_kms\_usage\_accounts) | Zero or more AWS Account IDs that need usage access to the KMS keys. The cross-acccount admin must provide IAM policies to enable access. | `list(string)` | `[]` | no |
| <a name="input_kms_usage_principal_arns"></a> [kms\_usage\_principal\_arns](#input\_kms\_usage\_principal\_arns) | Zero or more IAM roles ARNs that need usage access to the KMS keys, use this to allow access to cross-account principals | `list(string)` | `[]` | no |
| <a name="input_kms_usage_roles"></a> [kms\_usage\_roles](#input\_kms\_usage\_roles) | Zero or more IAM roles in the primary account that need usage access to the KMS keys | `list(string)` | `[]` | no |
| <a name="input_override_policy_acm"></a> [override\_policy\_acm](#input\_override\_policy\_acm) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_backup"></a> [override\_policy\_backup](#input\_override\_policy\_backup) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_dynamodb"></a> [override\_policy\_dynamodb](#input\_override\_policy\_dynamodb) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_ebs"></a> [override\_policy\_ebs](#input\_override\_policy\_ebs) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_efs"></a> [override\_policy\_efs](#input\_override\_policy\_efs) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_glue"></a> [override\_policy\_glue](#input\_override\_policy\_glue) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_kinesis"></a> [override\_policy\_kinesis](#input\_override\_policy\_kinesis) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_lambda"></a> [override\_policy\_lambda](#input\_override\_policy\_lambda) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_logs"></a> [override\_policy\_logs](#input\_override\_policy\_logs) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_rds"></a> [override\_policy\_rds](#input\_override\_policy\_rds) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_s3"></a> [override\_policy\_s3](#input\_override\_policy\_s3) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_secretsmanager"></a> [override\_policy\_secretsmanager](#input\_override\_policy\_secretsmanager) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_session"></a> [override\_policy\_session](#input\_override\_policy\_session) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_sns"></a> [override\_policy\_sns](#input\_override\_policy\_sns) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_sqs"></a> [override\_policy\_sqs](#input\_override\_policy\_sqs) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_override_policy_ssm"></a> [override\_policy\_ssm](#input\_override\_policy\_ssm) | A valid KMS key policy JSON document. If not specified, a canonical key policy will be used. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Common and mandatory tags for the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_aliases"></a> [key\_aliases](#output\_key\_aliases) | KMS key aliases that are created |
| <a name="output_key_policies"></a> [key\_policies](#output\_key\_policies) | KMS key policies that are created |
<!-- END_TF_DOCS -->
