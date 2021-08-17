resource "aws_security_group" "clevertap" {
  name        = "WordPress"
  description = "Allowing Wordpress application to be accessed by public"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description      = "Inbound Rules"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "WordPress"
  }
}