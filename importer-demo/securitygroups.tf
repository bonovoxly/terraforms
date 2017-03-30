# web1 instance security group
resource "aws_security_group" "web1" {
  description = "${ var.env } web1 instance security group"
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
  name = "${ var.env }-web1-inbound"
  tags {
    Name = "${ var.env }-web1-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
}

# db1 instance security group
resource "aws_security_group" "db1" {
  description = "${ var.env } db1 instance security group"
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
  name = "${ var.env }-db1-inbound"
  tags {
    Name = "${ var.env }-db1-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
}
