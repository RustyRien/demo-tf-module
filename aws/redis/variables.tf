variable "account" {
  type = string
}

variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "redis_version" {
  type = string
}

variable "node_type" {
  type = string
}

variable "parameters" {
  type = object({
    parameters = optional(list(any), [])
  })
  default = { "parameters" : [] }
}

variable "vpc_id" {
  type = string
}

variable "ingress_cidrs" {
  type        = list(string)
  default     = []
  description = "Cidr list to whitelist in Security Group"
}

variable "number_of_nodes" {
  type    = number
  default = 3
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "valkey_family" {
  type    = string
  default = "valkey8"
}

variable "default_user_access_string" {
  type        = string
  default     = "on ~* +@all"
  description = "use off -@all to disable token access and keep only IAM auth"
}

variable "user_prefix" {
  type        = string
  description = "Prefix for splitting users in different clusters. Use cluster name for simplicity."
  default     = "demo"
}
