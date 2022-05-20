//---------------------------------------------------------//
// Provider Variable
//---------------------------------------------------------//
variable "primary_region" {
  description = "The AWS Region e.g. us-east-1 for the primary KMS Key"
  type        = string
}

variable "replica_region" {
  description = "The AWS Region e.g. us-east-1 where replica will be created"
  type        = string
}

//---------------------------------------------------------//
// Common Variables
//---------------------------------------------------------//
variable "project" {
  description = "Project name (prefix/suffix) to be used for all the resource identifications"
  type        = string
}

variable "env_name" {
  description = "Environment name e.g. dev, prod"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Common and mandatory tags for the resources"
  type        = map(string)
  default     = {}
}
