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
  subnet_id                   = var.subnet_id
  security_groups             = [aws_security_group.bastion-host-sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-bastion_host"
  })
}


