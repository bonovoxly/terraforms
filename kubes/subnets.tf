# operations public subnet (VPN and other public facing instances)
resource "aws_subnet" "opspublic-c" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.0.0/24"
  availability_zone = "us-east-1c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-opspublic-subnet-c"
    Environment = "${ var.env }"
    Role = "dmz"
    Zone = "public"
  }
}

# ELB public subnet c
resource "aws_subnet" "elbpublic-c" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.1.0/24"
  availability_zone = "us-east-1c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-elbpublic-subnet-c"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "elb"
    Zone = "public"
  }
}

# ELB public subnet d
resource "aws_subnet" "elbpublic-d" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.2.0/24"
  availability_zone = "us-east-1d"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-elbpublic-subnet-d"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "elb"
    Zone = "public"
  }
}

# ELB public subnet e
resource "aws_subnet" "elbpublic-e" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.3.0/24"
  availability_zone = "us-east-1e"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-elbpublic-subnet-e"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "elb"
    Zone = "public"
  }
}

# operations private subnet (CFSSL and other internal instances)
resource "aws_subnet" "opsprivate-c" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.10.0/24"
  availability_zone = "us-east-1c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-opsprivate-subnet-c"
    Environment = "${ var.env }"
    Private = "yes"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
  }
}

# etcd subnet c
resource "aws_subnet" "etcd-c" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.11.0/24"
  availability_zone = "us-east-1c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-etcd-subnet-c"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "etcd"
    Zone = "private"
  }
}

# etcd subnet d
resource "aws_subnet" "etcd-d" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.12.0/24"
  availability_zone = "us-east-1d"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-etcd-subnet-d"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "etcd"
    Zone = "private"
  }
}

# etcd subnet e
resource "aws_subnet" "etcd-e" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.13.0/24"
  availability_zone = "us-east-1e"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-etcd-subnet-e"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "etcd"
    Zone = "private"
  }
}

# Kubernetes control plane subnet c
resource "aws_subnet" "controller-c" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.21.0/24"
  availability_zone = "us-east-1c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-controller-subnet-c"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "controlplane"
    Zone = "private"
  }
}

# Kubernetes control plane subnet d
resource "aws_subnet" "controller-d" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.22.0/24"
  availability_zone = "us-east-1d"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-controller-subnet-d"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "controlplane"
    Zone = "private"
  }
}

# Kubernetes control plane subnet e
resource "aws_subnet" "controller-e" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.23.0/24"
  availability_zone = "us-east-1e"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-controller-subnet-e"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "controlplane"
    Zone = "private"
  }
}

# Kubernetes internal node subnet c
resource "aws_subnet" "node-c" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.31.0/24"
  availability_zone = "us-east-1c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-node-subnet-c"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "internalnode"
    Zone = "private"
  }
}


# Kubernetes internal node subnet d
resource "aws_subnet" "node-d" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.32.0/24"
  availability_zone = "us-east-1d"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-node-subnet-d"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "internalnode"
    Zone = "private"
  }
}

# Kubernetes internal node subnet e
resource "aws_subnet" "node-e" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.33.0/24"
  availability_zone = "us-east-1e"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-node-subnet-e"
    Environment = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role = "internalnode"
    Zone = "private"
  }
}
