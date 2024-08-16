output "nat_gateway_id" {
  value       = aws_nat_gateway.nat[*].id
  description = "The ID of the NAT Gateway"
}

output "vpc_id" {
  value = aws_vpc.main.id
}
