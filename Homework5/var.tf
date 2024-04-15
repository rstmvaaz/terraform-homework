variable "region" {
  description = "Provide region"
  type        = string
}
variable "vpc_cidr" {
  type = list(object({
    vcidr          = string
    enbl_dns_sup   = bool
    enbl_dns_hostn = bool
  }))
  description = "Provide VPC cidr block"
}

variable "sub_cidr" {
  type = list(object({
    cidr     = string
    sub_name = string
  }))
  description = "Provide subnet cidr block"
}
variable "internet_gateway_name" {
  type        = string
  description = "Provide Internet Gateway name"
}
variable "route_table_name1" {
  type        = string
  description = "Provide route table name"
}
variable "route_table_name2" {
  type        = string
  description = "Provide route table name"
}
variable "vpc-name" {
  type = string
}
variable "ports" {
  type    = list(number)
  default = [22, 80]
}
variable "instance_type1" {
  type = list(object({
    ins_type = string
    ins_name = string
  }))
  description = "Provide instance type region"
}
variable "availability_zones" {
  type        = string
  description = "Provide availability zone"
}