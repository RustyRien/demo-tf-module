data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "*-elasticache-*"
  }
}

module "redis" {
  source = "git::ssh://git@github.com/RustyRien/demo-tf-module.git//modules/elasticache?ref=1.1.0"

  identifier      = var.name
  engine_version  = var.redis_version
  node_type       = var.node_type
  vpc_id          = var.vpc_id
  subnet_ids      = data.aws_subnets.subnets.ids
  parameters      = var.parameters.parameters
  number_of_nodes = var.number_of_nodes
  tags            = local.tags_lowercase
}
