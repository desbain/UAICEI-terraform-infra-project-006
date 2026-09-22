#creating vpc module #######################
resource "aws_vpc" "desbain-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

 tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-vpc"
  })
}

