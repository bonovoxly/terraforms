# openvpn security group
resource "aws_security_group" "openvpn" {
  description = "${ var.env } openvpn security group"
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
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # OpenVPN access from the VPN server
  ingress = {
    from_port =1194
    to_port = 1194
    protocol = "udp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  name = "${ var.env }-openvpn-inbound"
  tags {
    Name = "${ var.env }-openvpn-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
}

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
    cidr_blocks = [ "${ var.vpn_address }/32" ]
  }
  name = "${ var.env }-cfssl-inbound"
  tags {
    Name = "${ var.env }-cfssl-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
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
    cidr_blocks = [ "${ var.vpn_address }/32" ]
  }
  # Kubernetes control plane access
  ingress = {
    from_port = 2379
    to_port = 2379
    protocol = "tcp"
    cidr_blocks = [ "${ aws_subnet.controller-c.cidr_block }","${ aws_subnet.controller-d.cidr_block}","${ aws_subnet.controller-e.cidr_block}" ]
  }
  # Etcd client and server ports
  ingress = {
    from_port = 2379
    to_port = 2380
    protocol = "tcp"
    cidr_blocks = [ "${aws_subnet.etcd-c.cidr_block }","${aws_subnet.etcd-d.cidr_block }","${aws_subnet.etcd-e.cidr_block }" ]
  }
  name = "${ var.env }-etcd-inbound"
  tags {
    Name = "${ var.env }-etcd-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
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
    cidr_blocks = [ "${ var.vpn_address }/32" ]
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
    cidr_blocks = [ "${ var.vpn_address }/32" ]
  }
  # nodes
  ingress = {
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = [ "${aws_subnet.node-c.cidr_block }","${aws_subnet.node-d.cidr_block }","${aws_subnet.node-e.cidr_block }"  ]
  }
  name = "${ var.env }-controller-inbound"
  tags {
    Name = "${ var.env }-controller-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
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
    cidr_blocks = [ "${ var.vpn_address }/32" ]
  }
  # Kubernetes control plane
  ingress = {
    from_port = 10250
    to_port = 10250
    protocol = "tcp"
    cidr_blocks = [ "${ aws_subnet.controller-c.cidr_block }","${ aws_subnet.controller-d.cidr_block}","${ aws_subnet.controller-e.cidr_block}" ]
  }
  # nodes - weave net
  ingress = {
    from_port = 6783
    to_port = 6783
    protocol = "tcp"
    cidr_blocks = [ "${aws_subnet.node-c.cidr_block }","${aws_subnet.node-d.cidr_block }","${aws_subnet.node-e.cidr_block }"  ]
  }
  # nodes - weave net
  ingress = {
    from_port = 6783
    to_port = 6784
    protocol = "udp"
    cidr_blocks = [ "${aws_subnet.node-c.cidr_block }","${aws_subnet.node-d.cidr_block }","${aws_subnet.node-e.cidr_block }"  ]
  }
  # ELB ingress - TCP
  ingress = {
    from_port = 30000
    to_port = 32767
    protocol = "tcp"
    cidr_blocks = [ "${aws_subnet.elbpublic-c.cidr_block }","${aws_subnet.elbpublic-d.cidr_block }","${aws_subnet.elbpublic-e.cidr_block }"  ]
  }
  # ELB ingress - UDP
  ingress = {
    from_port = 30000
    to_port = 32767
    protocol = "udp"
    cidr_blocks = [ "${aws_subnet.elbpublic-c.cidr_block }","${aws_subnet.elbpublic-d.cidr_block }","${aws_subnet.elbpublic-e.cidr_block }"  ]
  }
  name = "${ var.env }-node-inbound"
  tags {
    Name = "${ var.env }-node-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
}
