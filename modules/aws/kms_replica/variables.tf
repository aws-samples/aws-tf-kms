/*---------------------------------------------------------
Provider Variable
---------------------------------------------------------*/
variable "primary_region" {
  description = "The AWS Region e.g. us-east-1 for the primary KMS Key"
  type        = string
}

variable "replica_region" {
  description = "The AWS Region e.g. us-west-1 where replica will be created"
  type        = string
}

/*---------------------------------------------------------
Common Variables
---------------------------------------------------------*/
variable "tags" {
  description = "Common and mandatory tags for the resources"
  type        = map(string)
  default     = {}
}

/*---------------------------------------------------------
KMS Replica Variables
---------------------------------------------------------*/
variable "deletion_window_in_days" {
  description = "The waiting period, after which the AWS KMS deletes the KMS key replica. It must be between 7 and 30. Default is 7."
  type        = number
  default     = 7
}

variable "replicas_to_create" {
  description = "Map of KMS aliases from Primary region for which replicas to be created in Replica region"
  type = map(object({
    alias  = string # Alias for the KMS Key in the primary region
    policy = string # Policy for the KMS Key in the primary region, or policy for the replica
  }))
  default = {}
}
