#========================== VPC  =============================

# Define a vpc
resource "aws_vpc" "ship_vpc" {
  cidr_block = "${var.ship_vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.install_version}"
  }
}

# Internet gateway for the public subnet
resource "aws_internet_gateway" "ship_ig" {
  vpc_id = "${aws_vpc.ship_vpc.id}"
  tags {
    Name = "ship_ig_${var.install_version}"
  }
}

#========================== 0.0 Subnet =============================

# Public subnet
resource "aws_subnet" "ship_sn" {
  vpc_id = "${aws_vpc.ship_vpc.id}"
  cidr_block = "${var.ship_sn_cidr}"
  availability_zone = "${var.avl_zone}"
  map_public_ip_on_launch = true
  tags {
    Name = "ship_sn_${var.install_version}"
  }
}

# Routing table for public subnet
resource "aws_route_table" "ship_rt_public" {
  vpc_id = "${aws_vpc.ship_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ship_ig.id}"
  }
  tags {
    Name = "ship_rt_public_${var.install_version}"
  }
}

# Associate the routing table to public subnet
resource "aws_route_table_association" "rt_assn_public" {
  subnet_id = "${aws_subnet.ship_sn.id}"
  route_table_id = "${aws_route_table.ship_rt_public.id}"
}

#========================== SG =============================

resource "aws_security_group" "ship_sg" {
  name = "ship_sg_${var.install_version}"
  description = "Shippable external traffic security group"
  vpc_id = "${aws_vpc.ship_vpc.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    from_port = 5671
    to_port = 5671
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    from_port = 15671
    to_port = 15671
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    from_port = "3389"
    to_port   = "3389"
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    # allow all traffic to private SN
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "${var.cidr_private_ship_install}"]
  }

  tags {
    Name = "ship_sg_${var.install_version}"
  }
}
