data "aws_vpc" "vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "this" {
  name_prefix = "${var.identifier}-"
  description = "Elasticache instance security group"
  vpc_id      = var.vpc_id

  # default ingress rules
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.vpc.cidr_block]
    description = "Allow all inbound traffic from the same VPC"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.ingress_cidrs
    description = "Allow all inbound traffic from allowed CIDR blocks"
  }

  # default egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "Allow all outbound traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
