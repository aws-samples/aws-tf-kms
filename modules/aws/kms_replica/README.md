<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.primary"></a> [aws.primary](#provider\_aws.primary) | >= 4.13.0 |
| <a name="provider_aws.replica"></a> [aws.replica](#provider\_aws.replica) | >= 4.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_replica_key.kms_key_replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_replica_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | The waiting period, after which the AWS KMS deletes the KMS key replica. It must be between 7 and 30. Default is 7. | `number` | `7` | no |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Environment name e.g. dev, prod | `string` | `"dev"` | no |
| <a name="input_primary_region"></a> [primary\_region](#input\_primary\_region) | The AWS Region e.g. us-east-1 for the primary KMS Key | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name (prefix/suffix) to be used for all the resource identifications | `string` | n/a | yes |
| <a name="input_replica_region"></a> [replica\_region](#input\_replica\_region) | The AWS Region e.g. us-east-1 where replica will be created | `string` | n/a | yes |
| <a name="input_replicas_to_create"></a> [replicas\_to\_create](#input\_replicas\_to\_create) | Map of KMS aliases from Primary region for which replicas to be created in Replica region | <pre>map(object({<br>    alias  = string # Alias for the KMS Key in the primary region<br>    policy = string # Policy for the KMS Key in the primary region, or policy for the replica<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Common and mandatory tags for the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_aliases"></a> [key\_aliases](#output\_key\_aliases) | KMS key replica aliases that are created |
<!-- END_TF_DOCS -->