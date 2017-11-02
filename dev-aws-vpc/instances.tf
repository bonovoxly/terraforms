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

# vpn instance
resource "aws_instance" "openvpn" {
  ami                  = "${ data.aws_ami.ubuntu.id }"
  iam_instance_profile = "${ var.env }-openvpn-profile"
  instance_type        = "t2.small"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name               = "${ var.keypair }"
  private_ip             = "${ var.cidr }.0.4"
  subnet_id              = "${ aws_subnet.opspublic-a.id }"
  tenancy                = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.openvpn.id }"]
  tags {
    Name              = "${ var.env }-openvpn"
    terraform_id      = "${ var.env }-terraform"
    Environment       = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role              = "vpn"
    sshUser           = "ubuntu"
    prometheus_node   = "9100"
  }
}

