resource "aws_security_group" "wordpress" {
  description = "Security group created for Wordpress Clevertap"
  name        = var.name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "service_in_lb" {
  description = "Inbound Rules"

  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]

  security_group_id = aws_security_group.wordpress.id
}
resource "aws_security_group_rule" "service_out_lb" {
  description = "Outbound RUles"

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.wordpress.id
}
