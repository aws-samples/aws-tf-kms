# Scenario 3: Create AWS KMS key(s) in the owner account and allow cross-account access via AWS Services and the account principals
Create one or more AWS KMS keys in the one account. Allow principal(s) and AWS Services in the trusted account(s) to use the AWS KMS keys in their account.

<p align="center"><img src="../../../images/aws-tf-kms-Scenario-3.png" width="75%"/></p>

- Account owner has full access to the key(s)
- Key Admin role in the owner account has administrative access to the key(s)
- Key Usage role(s) in the owner account have the usage access to the key(s)
- Target AWS Service usage role(s) in the owner account have the usage access to the key via the target AWS Service in the owner account
- Trusted account `root` has the usage and grand access to the Key(s). It can delegate usage access to other principals in the trusted account.
- Key Usage role(s) in the trusted account have the usage access to the key(s)
- Target AWS Service usage role(s) in the trusted account have the usage access to the key via the target AWS Service in the trusted account

## Prerequisites

- One or more IAM roles for the `Administration` of the keys are identified.
- Zero or more IAM roles for the `Usage` of the keys are identified.
- A unique alias prefix is identified that will be used to uniformly name the key aliases.
- One or more external accounts are identified along with zero or more cross-account principal ARNs.
- Terraform backend provider and state locking providers are identified and bootstrapped.
  - An [example bootstrap](../../../bootstrap) module/example is provided that provisions Amazon S3 for Terraform state storage and Amazon DynamoDB for Terraform state locking.
- Modify `terraform.tfvars` to match your requirements.

## Execution

- cd to `examples/kms/scenario3` folder.
- Modify `backend "S3"` section in the `provider.tf` with correct values for `region`, `bucket`, `dynamodb_table`, and `key`.
  - Use provided values as guidance.
- Modify `terraform.tfvars` to your requirements.
  - Use provided values as guidance.
- Make sure you are using the correct AWS Profile that has permission to provision the target resources.
  - `aws sts get-caller-identity`
- Execute `terraform init` to initialize Terraform.
- Execute `terraform plan` and verify the changes.
- Execute `terraform apply` and approve the changes to provision the resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= v1.1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.13.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms_keys"></a> [kms\_keys](#module\_kms\_keys) | ../../../modules/aws/kms | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_usage_accounts"></a> [kms\_usage\_accounts](#input\_kms\_usage\_accounts) | List of trusted account Ids | `list(string)` | n/a | yes |
| <a name="input_kms_usage_principal_arns"></a> [kms\_usage\_principal\_arns](#input\_kms\_usage\_principal\_arns) | List of cross-account principal ARNs | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name (prefix/suffix) to be used on all the resources identification | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS Region e.g. us-east-1 for the environment | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Common and mandatory tags for the resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_keys"></a> [kms\_keys](#output\_kms\_keys) | KMS Keys created |
<!-- END_TF_DOCS -->
