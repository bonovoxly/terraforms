# Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

# VPC lookup
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-vpc"]
  }
}

# DNS lookup
data "aws_route53_zone" "zone" {
  name   = "${ var.dns }."
  private_zone = true
}

# opspublic-a subnet lookup
data "aws_subnet" "opspublic-a" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-opspublic-subnet-a"]
  }
}

# opsprivate-a subnet lookup
data "aws_subnet" "opsprivate-a" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-opsprivate-subnet-a"]
  }
}

# elbpublic-a subnet lookup
data "aws_subnet" "elbpublic-a" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-elbpublic-subnet-a"]
  }
}

# elbpublic-b subnet lookup
data "aws_subnet" "elbpublic-b" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-elbpublic-subnet-b"]
  }
}

# elbpublic-c subnet lookup
data "aws_subnet" "elbpublic-c" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-elbpublic-subnet-c"]
  }
}

# etcd-a subnet lookup
data "aws_subnet" "etcd-a" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-etcd-subnet-a"]
  }
}

# etcd-b subnet lookup
data "aws_subnet" "etcd-b" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-etcd-subnet-b"]
  }
}

# etcd-c subnet lookup
data "aws_subnet" "etcd-c" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-etcd-subnet-c"]
  }
}

# controller-a subnet lookup
data "aws_subnet" "controller-a" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-controller-subnet-a"]
  }
}

# controller-b subnet lookup
data "aws_subnet" "controller-b" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-controller-subnet-b"]
  }
}

# controller-c subnet lookup
data "aws_subnet" "controller-c" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-controller-subnet-c"]
  }
}

# node-a subnet lookup
data "aws_subnet" "node-a" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-node-subnet-a"]
  }
}

# node-b subnet lookup
data "aws_subnet" "node-b" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-node-subnet-b"]
  }
}

# node-c subnet lookup
data "aws_subnet" "node-c" {
  filter {
    name   = "tag:Name"
    values = ["${ var.env }-node-subnet-c"]
  }
}

# vpn address lookup
data "aws_instance" "vpn" {
  filter {
    name   = "tag:Role"
    values = ["vpn"]
  }
}
