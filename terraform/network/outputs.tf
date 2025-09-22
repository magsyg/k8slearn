output "main_vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "vpc_public_subnet" {
  value = aws_subnet.public_subnet
}
