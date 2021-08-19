resource "aws_efs_file_system" "wordpress" {
  tags = {
    Name = "Wordpress-Uploads"
}
}
resource "aws_efs_mount_target" "wordpress-mount" {
  file_system_id = aws_efs_file_system.wordpress.id
  subnet_id      = "subnet-98e1bac7"
  
}
