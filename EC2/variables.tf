variable "vpc_id" {
  type = string

}

variable "tags" {
  description = "list of local values"
  type        = map(string)

}

variable "ami_id" {
  description = "ami of ec2 instance"
  type        = string
}

variable "instance_type" {
  description = "type of instance"
  type        = string
}

variable "public_subnet_az2a_id" {
  description = "public subnet for bastion host"

}

variable "private_subnet_az2a_id" {
  description = "private subnet for private_server"

}

variable "private_subnet_az2b_id" {
  description = "private subnet for private_server"

}

variable "key_name" {
  description = "key for bastion host"
  type        = string

}