variable "environment" {
  type = string
  default = "env"
}

variable "app_name" {
  type = string
  default = "app"
}

locals {
  repository_name = format("%s-%s", var.app_name, var.environment)
}
