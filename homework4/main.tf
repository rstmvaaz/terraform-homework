provider aws {
    region = "{var.region}"
}

resource "aws_key_pair" "key" {
   key_name = "{var.key_name}"
   public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "SG" {
   name = "Allow SG"
   description = "Allow inbound traffic on ports 22,80 and 443 "
}

  
    ingress { 
    from_port        = var.ports[0]
    to_port          = var.ports[0]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }
    ingress {
    from_port        = var.ports[1]
    to_port          = var.ports[1]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }
 
    ingress {
    from_port        = var.ports[2]
    to_port          = var.ports[2]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }


resource "aws_instance" "instance" {
  count = "var.count"
  ami = "var.ami_id"
  instance_type = "var.instance_type"
  key_name = [aws_key_pair.key.key_name]
  security_groups = [aws_security_group.SG.name]
  availability_zone = "var.availability_zone"
}