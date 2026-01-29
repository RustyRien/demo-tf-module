resource "random_password" "password" {
  length  = 16
  special = false
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_parameter_group" "redis_parameter_group" {
  name        = "${var.identifier}-pg"
  family      = var.valkey_family
  description = "Redis parameter group for ${var.identifier}"

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = tostring(parameter.value.value)
    }
  }
}

resource "aws_elasticache_user" "default_user" {
  user_id       = "${var.user_prefix}-default-user"
  user_name     = "default"
  access_string = var.default_user_access_string
  engine        = "valkey"
  passwords     = [random_password.password.result]
}

resource "aws_elasticache_user_group" "default" {
  engine        = "valkey"
  user_group_id = var.identifier
  user_ids      = [aws_elasticache_user.default_user.user_id]
}

resource "aws_elasticache_replication_group" "redis" {
  engine               = "valkey"
  engine_version       = var.engine_version
  replication_group_id = var.identifier
  description          = "Valkey replication group for ${var.identifier}"
  node_type            = var.node_type
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [aws_security_group.this.id]
  num_cache_clusters   = var.number_of_nodes
  parameter_group_name = "default.${var.valkey_family}"
  user_group_ids       = [aws_elasticache_user_group.default.user_group_id]

  port                       = var.port
  multi_az_enabled           = var.multi_az_enabled
  automatic_failover_enabled = var.automatic_failover_enabled
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  apply_immediately          = var.apply_immediately
  snapshot_retention_limit   = var.snapshot_retention_limit
  tags                       = var.tags
}

