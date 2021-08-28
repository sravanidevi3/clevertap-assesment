resource "aws_efs_file_system" "wordpress" {
  tags = {
    Name = "Wordpress-Uploads"
}
}
resource "aws_efs_mount_target" "wordpress-mount" {
  file_system_id = aws_efs_file_system.wordpress.id
  subnet_id      = aws_subnet.subnet-clevertap-1.id
  security_groups = [aws_security_group.default.id]
}
