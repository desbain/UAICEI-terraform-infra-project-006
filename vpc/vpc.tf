#creating vpc module #######################
resource "aws_vpc" "desbain-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-vpc"
  })
}

#creating internet-gateway ######################################
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.desbain-vpc.id

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-igw"
  })
}

# creating public subnets az2a ################################

resource "aws_subnet" "public-subnet-az2a" {
  vpc_id     = aws_vpc.desbain-vpc.id
  cidr_block = var.public_cidr_block[0]
  availability_zone = var.availability_zone[0]
   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-public_subnet-az2a"
  })
}

# creating public subnets az2b ################################

resource "aws_subnet" "public-subnet-az2b" {
  vpc_id     = aws_vpc.desbain-vpc.id
  cidr_block = var.public_cidr_block[1]
  availability_zone = var.availability_zone[1]
   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-public_subnet-az2b"
  })
}

# creating private subnets az2a ################################

resource "aws_subnet" "private-subnet-az2a" {
  vpc_id     = aws_vpc.desbain-vpc.id
  cidr_block = var.private_cidr_block[0]
  availability_zone = var.availability_zone[0]
   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-private_subnet-az2a"
  })
}

# creating private subnets az2b ################################

resource "aws_subnet" "private-subnet-az2b" {
  vpc_id     = aws_vpc.desbain-vpc.id
  cidr_block = var.private_cidr_block[1]
  availability_zone = var.availability_zone[1]
   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-private_subnet-az2b"
  })
}


# creating database subnets az2a ################################

resource "aws_subnet" "db_subnet-az2a" {
  vpc_id     = aws_vpc.desbain-vpc.id
  cidr_block = var.db_cidr_block[0]
  availability_zone = var.availability_zone[0]
   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-db_subnet-az2a"
  })
}

# creating database subnets az2b ################################

resource "aws_subnet" "db_subnet-az2b" {
  vpc_id     = aws_vpc.desbain-vpc.id
  cidr_block = var.db_cidr_block[1]
  availability_zone = var.availability_zone[1]
   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-db_subnet-az2b"
  })
}