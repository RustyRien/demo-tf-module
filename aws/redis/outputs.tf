output "redis_primary_endpoint" {
  value = module.redis.redis_primary_endpoint
}

output "reader_endpoint_address" {
  value = module.redis.reader_endpoint_address
}

output "cluster_arn" {
  value = module.redis.arn
}

output "replication_group_id" {
  value = module.redis.replication_group_id
}
