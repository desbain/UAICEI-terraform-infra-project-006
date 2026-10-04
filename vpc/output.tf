output "vpc_id" {
  value = aws_vpc.desbain-vpc.id
}

output "public_subnet_az2a_id" {
  value = aws_subnet.public-subnet-az2a.id

}

output "private_subnet_az2a_id" {
  value = aws_subnet.private-subnet-az2a.id
}

output "private_subnet_az2b_id" {
  value = aws_subnet.private-subnet-az2a.id
}