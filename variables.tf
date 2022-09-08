variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "env" {
  default = "dev"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "pub_subnet_cidr" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# variable "priv_subnet_cidr" {
#   default = ["10.0.11.0/24", "10.0.22.0/24"]
# }
