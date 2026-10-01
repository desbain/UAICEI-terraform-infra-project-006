variable "vpc_cidr_block" {
  description = "cidr block of VPC"
  type        = string

}

variable "public_cidr_block" {
  description = "cidr block of public subnet"
  type        = list(string)

}

variable "private_cidr_block" {
  description = "cidr block of private subnet"
  type        = list(string)

}

variable "db_cidr_block" {
  description = "cidr block of database subnet"
  type        = list(string)

}

variable "availability_zone" {
  description = "availability zone of public subnet az2a"
  type        = list(string)

}