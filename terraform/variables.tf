variable "name" {
  type = string
  default = "wordpress-clevertap"
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
