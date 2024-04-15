provider "aws" {
  region = var.region
}

variable "region" {
  type        = string
  default     = ""
  description = "provide region"
}

variable "ami_id" {
  type        = string
  default     = ""
  description = "provide ami id"
}
variable "type" {
  type        = string
  default     = ""
  description = "provide instance type"
}

variable "key" {
  type        = string
  default = "Bastion-key"
  description = "The name for the key pair"
}

variable "count_vm" {
  type        = number
  default     = 1
  description = "count instances"
}

variable "availability_zones" {
  type = string
  default = ""
  description = "provide availibility zones"
}
variable ports {
  type        = list(number)
  default     = [22, 80, 443]
  description = "description"
}


resource "aws_instance" "vms" {
  ami                    = var.ami_id
  instance_type          = var.type
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  count                  = var.count_vm
  availability_zone      = var.availability_zones

}