provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "caxap"
  
}

terraform {
  backend "s3" {
    bucket = aws_s3_bucket.terraform_state.caxap
    key = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "state_lock"
  }
}

resource "aws_security_group" "allow_tls" {
    name = "allow_tls"
    description = "Allow TLS inbound traffic"
  
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "TLS from VPC"
    from_port        = 88
    to_port          = 88
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "web1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance[0].ec2_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id] 
  user_data              = file("apache.sh")
  tags = {
    Name = var.instance[0].ec2_name
  }
}