variable "vpc_cidr_block" {
    description = "cidr block of VPC"
    type = string
    
}


variable "tags" {
    description = "list of local values"
    type = map(string)
  
}