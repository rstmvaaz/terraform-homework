resource "aws_security_group" "allow_tls" {
   name = "allow_tls"
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


