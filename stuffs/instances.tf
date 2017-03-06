# Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

# openvpn instance
resource "aws_instance" "openvpn" {
  ami = "${ data.aws_ami.ubuntu.id }"
  associate_public_ip_address = true
  iam_instance_profile = "${ var.env }-openvpn-profile"
  instance_type = "t2.nano"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.0.4"
  subnet_id = "${ aws_subnet.opspublic-c.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.openvpn.id }"]
  tags {
    Name = "${ var.env }-openvpn"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "vpn"
    sshUser = "ubuntu"
  }
}

# example instance
resource "aws_instance" "example" {
  ami = "${ var.old_ami }"
  iam_instance_profile = "${ var.env }-example-profile"
  instance_type = "t2.nano"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.10.10"
  subnet_id = "${ aws_subnet.opsprivate-c.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.example.id }"]
  tags {
    Name = "${ var.env }-example"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "example"
    sshUser = "ubuntu"
  }
}
