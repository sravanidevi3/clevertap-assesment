resource "aws_db_instance" "clevertap" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "clevertap"
  identifier           = "clevertap"
  username             = "admin"
  password             = "admin123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids   = ["${aws_security_group.default.id}"]
  db_subnet_group_name = aws_db_subnet_group.clevertap.name
}

resource "aws_db_subnet_group" "clevertap" {
  name       = "clevertap"
  subnet_ids = [aws_subnet.subnet-clevertap-1.id,aws_subnet.subnet-clevertap-2.id]

  tags = {
    Name = "Subnet Group for RDS"
  }
}
