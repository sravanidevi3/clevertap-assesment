resource "aws_lb" "lb-wordpress-clevertap" {
    name = "lb-wordpress-clevertap"
    internal = "false"
    load_balancer_type = "application"
    security_groups = [aws_security_group.wordpress.id]
    subnets = data.aws_subnet_ids.subnets.ids
}

resource "aws_lb_target_group" "targetgrp-lb-clevertap" {
    name = "targetgrp-lb-clevertap"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    proxy_protocol_v2 = "false"
    target_type = "ip"

    health_check {
      enabled             = "true"
       port                = 80
       interval            = 20
       timeout             = 10
       path                = "/wp-admin/setup-config.php"
       protocol            = "HTTP"
       unhealthy_threshold = 10
       matcher             = 200
       healthy_threshold   = 10
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
