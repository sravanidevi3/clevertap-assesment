variable "name" {
  type = string
  default = "wordpress-clevertap"
}
variable "health_check" {
  type = map
  default = {
    interval = 60
    port                = 80
    healthy_threshold   = 10
    path                = "/"
    unhealthy_threshold = 10
    timeout             = 10
    protocol            = "HTTP"
    matcher             = 200
  }
}

variable "ecr_repository_url" {
  type        = string
  description = "Repository URL"
  default = "900024488048.dkr.ecr.us-east-1.amazonaws.com/bala-clever-tap"
}

variable "tag" {
 type = string
 default = "latest"
}
