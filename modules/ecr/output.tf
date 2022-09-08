output "ecr_repository_url" {
  value = aws_ecr_repository.ecr_repository.repository_url
}

output "reg_id" {
  value = aws_ecr_repository.ecr_repository.registry_id
}

output "app_name" {
  value = var.app_name
}
