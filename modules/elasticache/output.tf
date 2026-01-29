output "redis_primary_endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "reader_endpoint_address" {
  value = aws_elasticache_replication_group.redis.reader_endpoint_address
}

output "arn" {
  value = aws_elasticache_replication_group.redis.arn
}

output "replication_group_id" {
  value = aws_elasticache_replication_group.redis.replication_group_id
}

