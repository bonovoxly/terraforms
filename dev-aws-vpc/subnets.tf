# operations public subnet (VPN and other public facing instances)
resource "aws_subnet" "opspublic-a" {
  vpc_id            = "${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.0.0/24"
  availability_zone = "${ var.region }a"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-opspublic-subnet-a"
    Environment  = "${ var.env }"
    Role         = "dmz"
    Zone         = "public"
  }
}

# ELB public subnet a
resource "aws_subnet" "elbpublic-a" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.1.0/24"
  availability_zone = "${ var.region }a"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-elbpublic-subnet-a"
    Environment  = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role         = "elb"
    Zone         = "public"
  }
}

# ELB public subnet b
resource "aws_subnet" "elbpublic-b" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.2.0/24"
  availability_zone = "${ var.region }b"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-elbpublic-subnet-b"
    Environment  = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role         = "elb"
    Zone         = "public"
  }
}

# ELB public subnet c
resource "aws_subnet" "elbpublic-c" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.3.0/24"
  availability_zone = "${ var.region }c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-elbpublic-subnet-c"
    Environment  = "${ var.env }"
    KubernetesCluster = "${ var.kubernetes_cluster_id }"
    Role         = "elb"
    Zone         = "public"
  }
}

# operations private subnet a (CFSSL and other internal instances)
resource "aws_subnet" "opsprivate-a" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.4.0/24"
  availability_zone = "${ var.region }a"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-opsprivate-subnet-a"
    Environment  = "${ var.env }"
    Private = "yes"
  }
}

# operations private subnet b
resource "aws_subnet" "opsprivate-b" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.5.0/24"
  availability_zone = "${ var.region }b"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-opsprivate-subnet-b"
    Environment  = "${ var.env }"
    Private = "yes"
  }
}

# operations private subnet c
resource "aws_subnet" "opsprivate-c" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.6.0/24"
  availability_zone = "${ var.region }c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-opsprivate-subnet-c"
    Environment  = "${ var.env }"
    Private = "yes"
  }
}

# etcd subnet a
resource "aws_subnet" "etcd-a" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.11.0/24"
  availability_zone = "${ var.region }a"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-etcd-subnet-a"
    Environment  = "${ var.env }"
    Role         = "etcd"
    Zone         = "private"
  }
}

# etcd subnet b
resource "aws_subnet" "etcd-b" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.12.0/24"
  availability_zone = "${ var.region }b"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-etcd-subnet-b"
    Environment  = "${ var.env }"
    Role         = "etcd"
    Zone         = "private"
  }
}

# etcd subnet c
resource "aws_subnet" "etcd-c" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.13.0/24"
  availability_zone = "${ var.region }c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-etcd-subnet-c"
    Environment  = "${ var.env }"
    Role         = "etcd"
    Zone         = "private"
  }
}

# Kubernetes control plane subnet a
resource "aws_subnet" "controller-a" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.21.0/24"
  availability_zone = "${ var.region }a"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-controller-subnet-a"
    Environment  = "${ var.env }"
    Role         = "controlplane"
    Zone         = "private"
  }
}

# Kubernetes control plane subnet b
resource "aws_subnet" "controller-b" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.22.0/24"
  availability_zone = "${ var.region }b"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-controller-subnet-b"
    Environment  = "${ var.env }"
    Role         = "controlplane"
    Zone         = "private"
  }
}

# Kubernetes control plane subnet c
resource "aws_subnet" "controller-c" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.23.0/24"
  availability_zone = "${ var.region }c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-controller-subnet-c"
    Environment  = "${ var.env }"
    Role         = "controlplane"
    Zone         = "private"
  }
}

# Kubernetes internal node subnet a
resource "aws_subnet" "node-a" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.31.0/24"
  availability_zone = "${ var.region }a"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-node-subnet-a"
    Environment  = "${ var.env }"
    Role         = "internalnode"
    Zone         = "private"
  }
}


# Kubernetes internal node subnet b
resource "aws_subnet" "node-b" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.32.0/24"
  availability_zone = "${ var.region }b"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-node-subnet-b"
    Environment  = "${ var.env }"
    Role         = "internalnode"
    Zone         = "private"
  }
}

# Kubernetes internal node subnet c
resource "aws_subnet" "node-c" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.33.0/24"
  availability_zone = "${ var.region }c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-node-subnet-c"
    Environment  = "${ var.env }"
    Role         = "internalnode"
    Zone         = "private"
  }
}

# DB subnet a
resource "aws_subnet" "db-a" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.41.0/24"
  availability_zone = "${ var.region }a"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-db-subnet-a"
    Environment  = "${ var.env }"
    Role         = "DB"
    Zone         = "private"
  }
}

# DB subnet b
resource "aws_subnet" "db-b" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.42.0/24"
  availability_zone = "${ var.region }b"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-db-subnet-b"
    Environment  = "${ var.env }"
    Zone         = "private"
  }
}

# DB subnet c
resource "aws_subnet" "db-c" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.43.0/24"
  availability_zone = "${ var.region }c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-db-subnet-c"
    Environment  = "${ var.env }"
    Zone         = "private"
  }
}
