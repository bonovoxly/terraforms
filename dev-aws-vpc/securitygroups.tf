# openvpn security group
resource "aws_security_group" "openvpn" {
  description = "${ var.env } openvpn security group"
  # outgoing rules
  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # SSH access to the VPN server
  ingress = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # OpenVPN access from the VPN server
  ingress = {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  name = "${ var.env }-openvpn-inbound"
  tags {
    Name         = "${ var.env }-openvpn-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
}

