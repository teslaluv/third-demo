output "dev_public_subnet_ids" {
  value = module.vpc-dev.public_subnet_ids
}

output "dev_private_subnet_ids" {
  value = module.vpc-dev.private_subnet_ids
}

output "alb_dns" {
  value = "http://${module.vpc-dev.alb_dns}/"
}
