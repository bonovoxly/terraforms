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

# vpn instance (optional)
resource "aws_instance" "openvpn" {
  ami = "${ data.aws_ami.ubuntu.id }"
  associate_public_ip_address = true
  iam_instance_profile = "${ var.env }-openvpn-profile"
  instance_type = "t2.micro"
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
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "vpn"
    sshUser = "ubuntu"
  }
}

# cfssl instance
resource "aws_instance" "cfssl" {
  ami = "${ data.aws_ami.ubuntu.id }"
  iam_instance_profile = "${ var.env }-cfssl-profile"
  instance_type = "t2.micro"
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
  vpc_security_group_ids = ["${ aws_security_group.cfssl.id }"]
  tags {
    Name = "${ var.env }-cfssl"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "cfssl"
    sshUser = "ubuntu"
  }
}

# etcd instance - subnet c
resource "aws_instance" "etcd-c" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-etcd-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.11.${ count.index + 10}"
  subnet_id = "${ aws_subnet.etcd-c.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.etcd.id }"]
  tags {
    Name = "${ var.env }-etcd-c-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "etcd"
    sshUser = "ubuntu"
  }
}

# etcd instance - subnet d
resource "aws_instance" "etcd-d" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-etcd-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.12.${ count.index + 10}"
  subnet_id = "${ aws_subnet.etcd-d.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.etcd.id }"]
  tags {
    Name = "${ var.env }-etcd-d-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "etcd"
    sshUser = "ubuntu"
  }
}

# etcd instance - subnet e
resource "aws_instance" "etcd-e" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-etcd-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.13.${ count.index + 10}"
  subnet_id = "${ aws_subnet.etcd-e.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.etcd.id }"]
  tags {
    Name = "${ var.env }-etcd-e-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "etcd"
    sshUser = "ubuntu"
  }
}

# Kubernetes control plane instances - subnet c
resource "aws_instance" "controller-c" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-controller-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.21.${ count.index + 10}"
  subnet_id = "${ aws_subnet.controller-c.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.controller.id }"]
  tags {
    Name = "${ var.env }-controller-c-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "controller"
    sshUser = "ubuntu"
  }
}

# Kubernetes control plane instances - subnet d
resource "aws_instance" "controller-d" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-controller-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.22.${ count.index + 10}"
  subnet_id = "${ aws_subnet.controller-d.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.controller.id }"]
  tags {
    Name = "${ var.env }-controller-d-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "controller"
    sshUser = "ubuntu"
  }
}

# Kubernetes control plane instances - subnet d
resource "aws_instance" "controller-e" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-controller-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.23.${ count.index + 10}"
  subnet_id = "${ aws_subnet.controller-e.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.controller.id }"]
  tags {
    Name = "${ var.env }-controller-e-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "controller"
    sshUser = "ubuntu"
  }
}

# Kubernetes node instances - subnet c
resource "aws_instance" "node-c" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-node-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.31.${ count.index + 10}"
  subnet_id = "${ aws_subnet.node-c.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.node.id }"]
  tags {
    Name = "${ var.env }-node-c-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "node"
    sshUser = "ubuntu"
  }
}

# Kubernetes node instances - subnet d
resource "aws_instance" "node-d" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-node-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.32.${ count.index + 10}"
  subnet_id = "${ aws_subnet.node-d.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.node.id }"]
  tags {
    Name = "${ var.env }-node-d-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "node"
    sshUser = "ubuntu"
  }
}

# Kubernetes node instances - subnet e
resource "aws_instance" "node-e" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-node-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ var.cidr }.33.${ count.index + 10}"
  subnet_id = "${ aws_subnet.node-e.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.node.id }"]
  tags {
    Name = "${ var.env }-node-e-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "node"
    sshUser = "ubuntu"
  }
}
