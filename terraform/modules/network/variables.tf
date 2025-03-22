variable "vpc_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = list(string)
}


variable "pub_subnet1_name" {
  type = string
}

variable "pub_subnet1_cidr_block" {
  type = list(string)
}


variable "pub_subnet2_name" {
  type = string
}

variable "pub_subnet2_cidr_block" {
  type = list(string)
}


variable "prvt_subnet_name" {
  type = string
}

variable "prvt_subnet_cidr_block" {
  type = list(string)
}

