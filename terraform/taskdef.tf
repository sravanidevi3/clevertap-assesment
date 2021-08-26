resource "aws_ecs_task_definition" "taskdef-clevertap-wordpress" {
    family = "taskdef-clevertap-wordpress"
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    memory                   = "1024"
    cpu                      = "512"    
    execution_role_arn = "arn:aws:iam::900024488048:role/ecsecrTaskExecutionRole"
    container_definitions = <<DEFINITION
    [
        {
            "name" :  "taskdef-clevertap-wordpress",
            "image" : "${var.ecr_repository_url}:${var.tag}",
            "memory" : 1024,
            "cpu" : 512,
            "portMappings" : [
         {
          "containerPort" : 80,
          "hostPort" : 80,
          "protocol" : "tcp"
         }
      ],
        "essential" : true,
        "mountPoints":[
          {
            "containerPath": "/var/www/html/wp-content/uploads",
            "sourceVolume": "efs-wordpress"
          }
        ]
        }
    ]
    DEFINITION
  volume {
      name      = "efs-wordpress"
          efs_volume_configuration {
                file_system_id = aws_efs_file_system.wordpress.id
                      root_directory = "/var/www/html/wp-content/uploads"
                          }
                            }
                            }

resource "aws_ecs_service" "service-clevertap-wordpress" {
    name = "taskdef-clevertap-wordpress"
    cluster = aws_ecs_cluster.clevertap.id
    task_definition = aws_ecs_task_definition.taskdef-clevertap-wordpress.arn
    desired_count   = 1
    launch_type     = "FARGATE"
    deployment_minimum_healthy_percent = 100
    deployment_maximum_percent = 200  

    tags = {
      "env" = "Testing"
    }
    network_configuration {
      subnets = [aws_subnet.subnet-clevertap-1.id]
      security_groups = [aws_security_group.default.id]
      assign_public_ip = true
    }
    load_balancer {
       target_group_arn = aws_lb_target_group.targetgrp-lb-clevertap.arn
       container_name = "taskdef-clevertap-wordpress"
       container_port = 80
    }
    depends_on = [
      aws_lb.lb-wordpress-clevertap
    ]
}
