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
  private_ip = "${ cidrhost(data.aws_subnet.opsprivate-a.cidr_block, 10) }"
  subnet_id = "${ data.aws_subnet.opsprivate-a.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.cfssl.id }"]
  tags {
    Name = "${ var.env }-cfssl"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "cfssl"
    sshUser = "ubuntu"
  }
}

# etcd instance - subnet a
resource "aws_instance" "etcd-a" {
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
  private_ip = "${ cidrhost(data.aws_subnet.etcd-a.cidr_block, 10) }"
  subnet_id = "${ data.aws_subnet.etcd-a.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.etcd.id }"]
  tags {
    Name = "${ var.env }-etcd-a-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "etcd"
    sshUser = "ubuntu"
  }
}

# etcd instance - subnet b
resource "aws_instance" "etcd-b" {
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
  private_ip = "${ cidrhost(data.aws_subnet.etcd-b.cidr_block, 10) }"
  subnet_id = "${ data.aws_subnet.etcd-b.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.etcd.id }"]
  tags {
    Name = "${ var.env }-etcd-b-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "etcd"
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
  private_ip = "${ cidrhost(data.aws_subnet.etcd-c.cidr_block, 10) }"
  subnet_id = "${ data.aws_subnet.etcd-c.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.etcd.id }"]
  tags {
    Name = "${ var.env }-etcd-c-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "etcd"
    sshUser = "ubuntu"
  }
}

# Kubernetes control plane instances - subnet a
resource "aws_instance" "controller-a" {
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
  private_ip = "${ cidrhost(data.aws_subnet.controller-a.cidr_block, 10) }"
  subnet_id = "${ data.aws_subnet.controller-a.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.controller.id }"]
  tags {
    Name = "${ var.env }-controller-a-${ count.index }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "controller"
    sshUser = "ubuntu"
  }
}

# Kubernetes control plane instances - subnet b
resource "aws_instance" "controller-b" {
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
  private_ip = "${ cidrhost(data.aws_subnet.controller-b.cidr_block, 10) }"
  subnet_id = "${ data.aws_subnet.controller-b.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.controller.id }"]
  tags {
    Name = "${ var.env }-controller-b-${ count.index }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "controller"
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
  private_ip = "${ cidrhost(data.aws_subnet.controller-c.cidr_block, 10) }"
  subnet_id = "${ data.aws_subnet.controller-c.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.controller.id }"]
  tags {
    Name = "${ var.env }-controller-c-${ count.index }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "controller"
    sshUser = "ubuntu"
  }
}

# Kubernetes node instances - subnet a
resource "aws_instance" "node-a" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-node-profile"
  instance_type = "t2.medium"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ cidrhost(data.aws_subnet.node-a.cidr_block, 10) }"
  subnet_id = "${ data.aws_subnet.node-a.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.node.id }"]
  tags {
    Name = "${ var.env }-node-a-${ count.index }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "node"
    sshUser = "ubuntu"
  }
}

# Kubernetes node instances - subnet b
resource "aws_instance" "node-b" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-node-profile"
  instance_type = "t2.medium"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ cidrhost(data.aws_subnet.node-b.cidr_block, 10) }"
  subnet_id = "${ data.aws_subnet.node-b.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.node.id }"]
  tags {
    Name = "${ var.env }-node-b-${ count.index }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "node"
    sshUser = "ubuntu"
  }
}

# Kubernetes node instances - subnet c
resource "aws_instance" "node-c" {
  ami = "${ data.aws_ami.ubuntu.id }"
  count = "1"
  iam_instance_profile = "${ var.env }-node-profile"
  instance_type = "t2.medium"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ cidrhost(data.aws_subnet.node-c.cidr_block, 10) }"
  subnet_id = "${ data.aws_subnet.node-c.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.node.id }"]
  tags {
    Name = "${ var.env }-node-c-${ count.index }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "node"
    sshUser = "ubuntu"
  }
}

