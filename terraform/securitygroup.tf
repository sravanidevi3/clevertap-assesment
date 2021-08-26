resource "aws_security_group" "default" {
  description = "Security group created for Wordpress Clevertap"
  name        = var.name
  vpc_id = aws_vpc.vpc-clevertap.id
}

resource "aws_security_group_rule" "service_in_lb" {
  description = "Inbound Rules"

  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]

  security_group_id = aws_security_group.default.id
}
resource "aws_security_group_rule" "service_in_lb" {
  description = "Inbound Rules"

  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]

  security_group_id = aws_security_group.default.id
}
resource "aws_security_group_rule" "service_out_lb" {
  description = "Outbound RUles"

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.default.id
}
