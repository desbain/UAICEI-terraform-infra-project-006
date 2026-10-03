output "vpc_id" {
  value = aws_vpc.desbain-vpc.id
}

output "subnet_id" {
  value = aws_subnet.public-subnet-az2a.id

}