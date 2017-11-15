# cfssl security group
resource "aws_security_group" "cfssl" {
  description = "${ var.env } cfssl security group"
  # outgoing rules
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # SSH access from the VPN server
  ingress = {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_instance.vpn.private_ip }/32" ]
  }
  # nodes - Prometheus
  ingress = {
    from_port = 9100
    to_port = 9100
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.node-a.cidr_block }","${ data.aws_subnet.node-b.cidr_block }","${ data.aws_subnet.node-c.cidr_block }"  ]
  }
  name = "${ var.env }-cfssl-inbound"
  tags {
    Name = "${ var.env }-cfssl-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  data.aws_vpc.vpc.id }"
}


# etcd cluster security group
resource "aws_security_group" "etcd" {
  description = "${ var.env } etcd security group"
  # outgoing rules
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # SSH access from the VPN server
  ingress = {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_instance.vpn.private_ip }/32" ]
  }
  # Kubernetes control plane access
  ingress = {
    from_port = 2379
    to_port = 2379
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.controller-a.cidr_block }","${ data.aws_subnet.controller-b.cidr_block}","${ data.aws_subnet.controller-c.cidr_block}" ]
  }
  # Etcd client and server ports
  ingress = {
    from_port = 2379
    to_port = 2380
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.etcd-a.cidr_block }","${ data.aws_subnet.etcd-b.cidr_block }","${ data.aws_subnet.etcd-c.cidr_block }" ]
  }
  # nodes - Prometheus
  ingress = {
    from_port = 9100
    to_port = 9100
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.node-a.cidr_block }","${ data.aws_subnet.node-b.cidr_block }","${ data.aws_subnet.node-c.cidr_block }"  ]
  }
  name = "${ var.env }-etcd-inbound"
  tags {
    Name = "${ var.env }-etcd-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  data.aws_vpc.vpc.id }"
}

# Kubernetes control plane security group
resource "aws_security_group" "controller" {
  description = "${ var.env } Kubernetes control plane security group"
  # outgoing rules
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # SSH access from the VPN server
  ingress = {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_instance.vpn.private_ip }/32" ]
  }
  # Jenkins access
  ingress = {
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = [ "10.0.2.0/24" ]
  }
  # Kubectl access.
  ingress = {
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_instance.vpn.private_ip }/32" ]
  }
  # nodes
  ingress = {
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.node-a.cidr_block }","${ data.aws_subnet.node-b.cidr_block }","${ data.aws_subnet.node-c.cidr_block }"  ]
  }
  # nodes - Prometheus
  ingress = {
    from_port = 9100
    to_port = 9100
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.node-a.cidr_block }","${ data.aws_subnet.node-b.cidr_block }","${ data.aws_subnet.node-c.cidr_block }"  ]
  }
  name = "${ var.env }-controller-inbound"
  tags {
    Name = "${ var.env }-controller-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  data.aws_vpc.vpc.id }"
}

# node security group
resource "aws_security_group" "node" {
  description = "${ var.env } node security group"
  # outgoing rules
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # SSH access from the VPN server
  ingress = {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_instance.vpn.private_ip }/32" ]
  }
  # Kubernetes control plane
  ingress = {
    from_port = 10250
    to_port = 10250
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.controller-a.cidr_block }","${ data.aws_subnet.controller-b.cidr_block}","${ data.aws_subnet.controller-c.cidr_block}" ]
  }
  # nodes - weave net
  ingress = {
    from_port = 6783
    to_port = 6783
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.node-a.cidr_block }","${ data.aws_subnet.node-b.cidr_block }","${ data.aws_subnet.node-c.cidr_block }"  ]
  }
  # nodes - weave net
  ingress = {
    from_port = 6783
    to_port = 6784
    protocol = "udp"
    cidr_blocks = [ "${ data.aws_subnet.node-a.cidr_block }","${ data.aws_subnet.node-b.cidr_block }","${ data.aws_subnet.node-c.cidr_block }"  ]
  }
  # nodes - Prometheus
  ingress = {
    from_port = 9100
    to_port = 9100
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.node-a.cidr_block }","${ data.aws_subnet.node-b.cidr_block }","${ data.aws_subnet.node-c.cidr_block }"  ]
  }
  # ELB ingress - TCP
  ingress = {
    from_port = 30000
    to_port = 32767
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.elbpublic-a.cidr_block }","${ data.aws_subnet.elbpublic-b.cidr_block }","${ data.aws_subnet.elbpublic-c.cidr_block }"  ]
  }
  # ELB ingress - UDP
  ingress = {
    from_port = 30000
    to_port = 32767
    protocol = "udp"
    cidr_blocks = [ "${ data.aws_subnet.elbpublic-a.cidr_block }","${ data.aws_subnet.elbpublic-b.cidr_block }","${ data.aws_subnet.elbpublic-c.cidr_block }"  ]
  }
  name = "${ var.env }-node-inbound"
  tags {
    Name = "${ var.env }-node-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  data.aws_vpc.vpc.id }"
}

# EFS security group
resource "aws_security_group" "efs" {
  description = "${ var.env } efs security group"
  # Kubernetes node access
  ingress = {
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.node-a.cidr_block }","${ data.aws_subnet.node-b.cidr_block}","${ data.aws_subnet.node-c.cidr_block}" ]
  }
  name = "${ var.env }-efs-inbound"
  tags {
    Name = "${ var.env }-efs-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  data.aws_vpc.vpc.id }"
}


# controller ELB security group
resource "aws_security_group" "controller-elb-inbound" {
  description = "${ var.env } controller public ELB"
  # outgoing rules
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress = {
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  name = "${ var.env }-controller-elb-inbound"
  tags {
    Name = "${ var.env }-controller-elb-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  data.aws_vpc.vpc.id }"
}
