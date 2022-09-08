output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "igw_id" {
  value = aws_internet_gateway.main.id
}

output "alb_dns" {
  value = aws_lb.test-lb.dns_name
}

