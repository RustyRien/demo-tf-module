variable "identifier" {
  type        = string
  description = "Replication group identifier."
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids to add to subnet group."
}

variable "engine_version" {
  type    = string
  default = "8.0"
}

variable "valkey_family" {
  type    = string
  default = "valkey8"
}

variable "node_type" {
  type    = string
  default = "cache.t3.small"
}

variable "number_of_nodes" {
  type    = number
  default = 3
}

variable "parameters" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "ingress_cidrs" {
  type        = list(string)
  default     = ["10.255.0.0/16"] # devops account
  description = "CIDR blocks to whitelist in Security Group"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "default_user_access_string" {
  type        = string
  description = "Default user access string."
  default     = "off -@all"
}

variable "user_prefix" {
  type        = string
  description = "Prefix for splitting users in different clusters"
}

variable "port" {
  type        = number
  description = "Port for Valkey"
  default     = 6379
}

variable "multi_az_enabled" {
  type    = bool
  default = true
}

variable "snapshot_retention_limit" {
  type        = number
  description = "Number of days to retain automatic snapshots."
  default     = 7
}

variable "automatic_failover_enabled" {
  type    = bool
  default = true
}

variable "auto_minor_version_upgrade" {
  type    = bool
  default = true
}

variable "at_rest_encryption_enabled" {
  type    = bool
  default = true
}

variable "transit_encryption_enabled" {
  type    = bool
  default = true
}

variable "apply_immediately" {
  type    = bool
  default = true
}
