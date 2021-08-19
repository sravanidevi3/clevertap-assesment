resource "aws_lb" "lb-wordpress-clevertap" {
    name = "lb-wordpress-clevertap"
    internal = "false"
    load_balancer_type = "application"
    security_groups = [aws_security_group.wordpress.id]
    subnets = [aws_subnet.subnet-clevertap-1.id,aws_subnet.subnet-clevertap-2.id]
}

resource "aws_lb_target_group" "targetgrp-lb-clevertap" {
    name = "targetgrp-lb-clevertap"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc-clevertap.id
    proxy_protocol_v2 = "false"
    target_type = "ip"

    health_check {
      enabled             = "true"
       port                = 80
       interval            = 20
       timeout             = 15
       path                = "/wp-admin/setup-config.php"
       protocol            = "HTTP"
       unhealthy_threshold = 15
       matcher             = 200
       healthy_threshold   = 15
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
