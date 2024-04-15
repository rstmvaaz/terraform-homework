provider "aws" {
  region = var.region
}

resource "aws_vpc" "kaizen" {
  cidr_block           = var.vpc_cidr[0].vcidr
  enable_dns_support   = var.vpc_cidr[0].enbl_dns_sup
  enable_dns_hostnames = var.vpc_cidr[0].enbl_dns_hostn
  tags = {
    Name = var.vpc-name
  }
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.kaizen.id
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zones}a"
  cidr_block              = var.sub_cidr[0].cidr

  tags = {
    Name = var.sub_cidr[0].sub_name
  }
}
resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.kaizen.id
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zones}b"
  cidr_block              = var.sub_cidr[1].cidr

  tags = {
    Name = var.sub_cidr[1].sub_name
  }
}
resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.kaizen.id
  availability_zone       = "${var.availability_zones}c"
  cidr_block              = var.sub_cidr[2].cidr

  tags = {
    Name = var.sub_cidr[2].sub_name
  }
}
resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.kaizen.id
  availability_zone       = "${var.availability_zones}d"
  cidr_block              = var.sub_cidr[3].cidr

  tags = {
    Name = var.sub_cidr[3].sub_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.kaizen.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.kaizen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.route_table_name1
  }
}
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.kaizen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.route_table_name2
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private-rt.id
}