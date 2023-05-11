resource "aws_security_group" "sg_bgr_infra" {
  #tfsec:ignore:aws-ec2-no-public-ingress-sgr
  name        = "BGR-infra-data"
  description = "private-sg-bgr-infra"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

