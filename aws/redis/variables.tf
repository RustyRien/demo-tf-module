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
  type    = string
  default = "8.2"
}

variable "node_type" {
  type    = string
  default = "cache.t3.micro"
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

