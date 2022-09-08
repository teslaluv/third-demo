variable "aws_region" {
  description = "AWS region"
  default = "us-east-1"
}

variable "key_name" {
  type        = string
  description = "The name for ssh key, used for aws_launch_configuration"
  default = "test-key-dev"
}

variable "cluster_name" {
  type        = string
  description = "The name of AWS ECS cluster"
  default = "test-dev-cluster"
}

locals {
  repository_name = format("%s-%s", var.app_name, var.environment)
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "env" {
  default = "dev"
}

variable "public_subnet_cidrs" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "private_subnet_cidrs" {
  default = [
    "10.0.11.0/24",
    "10.0.22.0/24",
    "10.0.33.0/24"
  ]
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5000
}

variable "number_cpu" {
  type = number
  description = "Instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = 4
}

variable "number_memory" {
  type = number
  description = "Instance memory to provision (in MiB)"
  default     = 256
}

variable "environment" {
  type = string
  default = "env"
}

variable "app_name" {
  type = string
  default = "flask"
}

variable "taskdef_template" {
  default = "/home/teslaluv/demo3/project/container-definitions/cb_application.json.tpl"
}

variable "app_image" {
  type = string
  # default = "174462142093.dkr.ecr.us-east-1.amazonaws.com/test-rep:latest"
  # 174462142093.dkr.ecr.us-east-1.amazonaws.com/app-env
  default = "716735117304.dkr.ecr.us-east-1.amazonaws.com/app-env:latest"
}

# locals {
#   app_image = format("%s:%s", var.ecr_repository_url, var.image_tag)
# }

# variable "ecr_repository_url" {
#   type = string
# }

# variable "image_tag" {
#   type = string
# }

variable "ec2-sg-name" {
  type = string
  default = "allow-all-ec2"
}

variable "ec2-sg-description" {
  type = string
  default = "allow all"
}

# variable "lc-name" {
#   type = string
#   default = "test_ecs"
# }

# variable "lc-instance-type" {
#   type = string
#   default = "t2.micro"
# }

variable "ltemplate-name" {
  type = string
  default = "test_ecs"
}

variable "ltemplate-instance-type" {
  type = string
  default = "t2.micro"
}

variable "asg-name" {
  type = string
  default = "test-asg"
}

variable "ecs_capacity_provider_name" {
  type = string
  default = "capacity-provider-test"
}

variable "task_definition_family" {
  type = string
  default = "web-family"
}

variable "task_definition_network_mode" {
  type = string
  default = "bridge"
}

variable "ecs-service-name" {
  type = string
  default = "web-service"
}

variable "ecs-container-name" {
  type = string
  default = "flask-app"
}

variable "ecs-container-port" {
  type = number
  default = 5000
}

variable "lb-name" {
  default = "test-ecs-lb"
}

variable "lb-type" {
  default = "application"
}

variable "sec-group-lb-name" {
  default = "allow-all-lb"
}

variable "lb-target-group-name" {
  default = "lb-target-group"
}

variable "lb-target-group-port" {
  default = "80"
}

variable "lb-target-group-protocol" {
  default = "HTTP"
}

variable "lb-target-group-type" {
  default = "instance"
}

variable "lb-listener-port" {
  default = "80"
}

variable "lb-listener-protocol" {
  default = "HTTP"
}
