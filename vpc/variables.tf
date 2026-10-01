variable "vpc_cidr_block" {
  description = "cidr block of VPC"
  type        = string

}


variable "tags" {
  description = "list of local values"
  type        = map(string)

}

variable "public_cidr_block" {
  description = "cidr block of public subnet az2a"
  type = list(string)
  
}

variable "private_cidr_block" {
  description = "cidr block of public subnet az2a"
  type = list(string)
  
}

variable "availability_zone" {
   description = "availability zone of public subnet az2a"
  type = list(string)
  
}