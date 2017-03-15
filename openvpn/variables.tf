# kubernetes demo

# variable to identify environment
variable "env" {
  type = "string"
  default = "inventory_demo"
}

# VPC/subnet first two octet CIDR to use
variable "cidr" {
 type = "string"
 default = "10.213"
}

# SSH key pair to use.  This needs to be in AWS.
variable "keypair" {
  type = "string"
  default = "dev"
}

# AWS region
variable "region" {
  type = "string"
  default = "us-east-1"
}

# if you need to define tenancy
variable "tenancy" {
  type = "string"
  default = "default"
}

variable "vpn_address" {
  type = "string"
  default = "10.213.0.4"
}
