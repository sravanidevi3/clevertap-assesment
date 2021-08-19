resource "aws_ecs_cluster" "clevertap" {
  name = "WordPress"
  capacity_providers = ["FARGATE"]
}



