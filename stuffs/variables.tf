# stuffs demo - an inventory management system using Terraform, Ansible, AWS S3, and Hugo

# example AMI
variable "old_ami" {
  type = "string"
  default = "ami-cf68e0d8"
}

# variable to identify environment
variable "env" {
  type = "string"
  default = "corp"
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

# stuffs bucket name - this must be unique
variable "stuffs_bucket_name" {
  type = "string"
  default = "stuffs-demo-bucket"
}

# stuffs bucket permissions - for production environments, recommend using 'private'
variable "stuffs_bucket_acl" {
  type = "string"
  default = "public-read"
}

# if you need to define tenancy
variable "tenancy" {
  type = "string"
  default = "default"
}

# private IP address of the VPN host, to allow SSH inbound
variable "vpn_address" {
  type = "string"
  default = "10.213.0.4"
}
