resource "aws_lb" "lb-wordpress-clevertap" {
    name = "lb-wordpress-clevertap"
    internal = "false"
    load_balancer_type = "application"
    security_groups = [aws_security_group.default.id]
    subnets = [aws_subnet.subnet-clevertap-1.id,aws_subnet.subnet-clevertap-2.id]
}

resource "aws_lb_target_group" "targetgrp-lb-clevertap" {
    name = "targetgrp-lb-clevertap"
    port = var.health_check.port
    protocol = var.health_check.protocol
    vpc_id = aws_vpc.vpc-clevertap.id
    target_type = "ip"

    health_check {
      enabled             = "true"
       port                = var.health_check.port
       interval            = var.health_check.interval
       timeout             = var.health_check.timeout
       path                = var.health_check.path
       protocol            = var.health_check.protocol
       unhealthy_threshold = var.health_check.unhealthy_threshold    
       matcher             = var.health_check.matcher
       healthy_threshold   = var.health_check.healthy_threshold
  }
}

resource "aws_lb_listener" "lb-wordpress-clevertap" {
    load_balancer_arn = aws_lb.lb-wordpress-clevertap.arn
    port = "80"
    protocol = "HTTP"
    
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.targetgrp-lb-clevertap.arn
    }  
}

resource "aws_lb_listener_rule" "rule-lb-clevertap" {
    listener_arn = aws_lb_listener.lb-wordpress-clevertap.arn
    priority = 100

    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.targetgrp-lb-clevertap.arn
    }
    condition {
      
      path_pattern {
        values = ["/wp-admin/setup-config.php"]
      }
    }
  
}
