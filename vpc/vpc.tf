#creating vpc module #######################
resource "aws_vpc" "desbain-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-vpc"
  })
}

#creating internet-gateway ######################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.desbain-vpc.id

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-igw"
  })
}

# creating public subnets az2a ################################

resource "aws_subnet" "public-subnet-az2a" {
  vpc_id            = aws_vpc.desbain-vpc.id
  cidr_block        = var.public_cidr_block[0]
  availability_zone = var.availability_zone[0]
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-public_subnet-az2a"
  })
}

# creating public subnets az2b ################################

resource "aws_subnet" "public-subnet-az2b" {
  vpc_id            = aws_vpc.desbain-vpc.id
  cidr_block        = var.public_cidr_block[1]
  availability_zone = var.availability_zone[1]
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-public_subnet-az2b"
  })
}

# creating private subnets az2a ################################

resource "aws_subnet" "private-subnet-az2a" {
  vpc_id            = aws_vpc.desbain-vpc.id
  cidr_block        = var.private_cidr_block[0]
  availability_zone = var.availability_zone[0]
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-private_subnet-az2a"
  })
}

# creating private subnets az2b ################################

resource "aws_subnet" "private-subnet-az2b" {
  vpc_id            = aws_vpc.desbain-vpc.id
  cidr_block        = var.private_cidr_block[1]
  availability_zone = var.availability_zone[1]
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-private_subnet-az2b"
  })
}


# creating database subnets az2a ################################

resource "aws_subnet" "db_subnet-az2a" {
  vpc_id            = aws_vpc.desbain-vpc.id
  cidr_block        = var.db_cidr_block[0]
  availability_zone = var.availability_zone[0]
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-db_subnet-az2a"
  })
}

# creating database subnets az2b ################################

resource "aws_subnet" "db_subnet-az2b" {
  vpc_id            = aws_vpc.desbain-vpc.id
  cidr_block        = var.db_cidr_block[1]
  availability_zone = var.availability_zone[1]
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-db_subnet-az2b"
  })
}

#creating public route table az2a ########################################

resource "aws_route_table" "public_route_tb_az2a" {
  vpc_id = aws_vpc.desbain-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-public_rt_az2a"
  })
}

# creating route table association for pubic route table az2a ##############
resource "aws_route_table_association" "public_rt_assoc_az2a" {
  subnet_id      = aws_subnet.public-subnet-az2a.id
  route_table_id = aws_route_table.public_route_tb_az2a.id
}

#creating public route table az2b########################################

resource "aws_route_table" "public_route_tb_az2b" {
  vpc_id = aws_vpc.desbain-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-public_rt_az2b"
  })
}

# creating route table association for pubic route table az2b ##############
resource "aws_route_table_association" "public_rt_assoc-az2b" {
  subnet_id      = aws_subnet.public-subnet-az2b.id
  route_table_id = aws_route_table.public_route_tb_az2b.id
}



#creating elastic ip address for nat gateway ##########################################
resource "aws_eip" "az2a_eip" {
  domain = "vpc"
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-eip"
  })

}

# creating nat gateway#####################################################

resource "aws_nat_gateway" "desbain-ngw-az2a" {
  allocation_id = aws_eip.az2a_eip.id
  subnet_id     = aws_subnet.public-subnet-az2a.id

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain_ngw_az2a"
  })

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.az2a_eip, aws_subnet.public-subnet-az2a]
}

#creating private route table az2a#############################

resource "aws_route_table" "private_route_tb_az2a" {
  vpc_id = aws_vpc.desbain-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.desbain-ngw-az2a.id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-private-rt-az2a"
  })
}

# creating route table association for private route table ##############
resource "aws_route_table_association" "private_rt_assoc-az2a" {
  subnet_id      = aws_subnet.private-subnet-az2a.id
  route_table_id = aws_route_table.private_route_tb_az2a.id
}

resource "aws_route_table_association" "db_subnet_assoc-az2a" {
  subnet_id      = aws_subnet.db_subnet-az2a.id
  route_table_id = aws_route_table.private_route_tb_az2a.id
}

#creating private subnet for az2b ###########################################################

#creating elastic ip address for nat gateway az2b ##########################################
resource "aws_eip" "az2b_eip" {
  domain = "vpc"
  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-eip-az2b"
  })

}

# creating nat gateway for az2b  #####################################################

resource "aws_nat_gateway" "desbain-ngw-az2b" {
  allocation_id = aws_eip.az2b_eip.id
  subnet_id     = aws_subnet.public-subnet-az2b.id

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain_ngw_az2b"
  })

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.az2b_eip, aws_subnet.public-subnet-az2b]
}

#creating private route table az2b*#############################

resource "aws_route_table" "private_route_tb_az2b" {
  vpc_id = aws_vpc.desbain-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.desbain-ngw-az2b.id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-desbain-private-rt-az2b"
  })
}

# creating route table association for private route table ##############
resource "aws_route_table_association" "private_rt_assoc-az2b" {
  subnet_id      = aws_subnet.private-subnet-az2b.id
  route_table_id = aws_route_table.private_route_tb_az2b.id
}

resource "aws_route_table_association" "db_subnet_assoc-az2b" {
  subnet_id      = aws_subnet.db_subnet-az2b.id
  route_table_id = aws_route_table.private_route_tb_az2b.id
}
