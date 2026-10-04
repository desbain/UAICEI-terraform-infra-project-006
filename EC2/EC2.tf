# CREATING SECURITY GROUP for bastion host #######################################

resource "aws_security_group" "bastion-host-sg" {
  name        = "bastion-host-sg"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-bastion_host_sg"
  })
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.bastion-host-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.bastion-host-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#creating a bastion-host #####################################

resource "aws_instance" "bastion-host" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_az2a_id
  security_groups             = [aws_security_group.bastion-host-sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-bastion_host"
  })
}

# CREATING SECURITY GROUP for private server #######################################

resource "aws_security_group" "private-server-sg" {
  name        = "private-sever-sg"
  description = "Allow SSH inbound traffic "
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_server_sg"
  })
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh_private_server" {
  security_group_id = aws_security_group.private-server-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_ssh" {
  security_group_id = aws_security_group.private-server-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#creating a private server in az2a ####################################################

resource "aws_instance" "private-server-az2a" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_az2a_id
  security_groups             = [aws_security_group.private-server-sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = false

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_server_az2a"
  })
}

#creating a private server in az2b ####################################################

resource "aws_instance" "private-server-az2b" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_az2b_id
  security_groups             = [aws_security_group.private-server-sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = false

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_server_az2b"
  })
}
