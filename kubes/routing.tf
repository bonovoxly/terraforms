# private route
resource "aws_route_table" "private" {
  vpc_id = "${ aws_vpc.main.id }"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${ aws_nat_gateway.nat.id }"
  }
  tags {
    Name = "${ var.env }-private-route"
    terraform_id = "${ var.env }-terraform"
  }
}

# public route
resource "aws_route_table" "public" {
  vpc_id = "${ aws_vpc.main.id }"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${ aws_internet_gateway.main.id }"
  }
  tags {
    Name = "${ var.env }-public-route"
    terraform_id = "${ var.env }-terraform"
  }
}

# opspublic-c association
resource "aws_route_table_association" "opspublic-c" {
  subnet_id = "${ aws_subnet.opspublic-c.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# elbpublic-c association
resource "aws_route_table_association" "elbpublic-c" {
  subnet_id = "${ aws_subnet.elbpublic-c.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# elbpublic-d association
resource "aws_route_table_association" "elbpublic-d" {
  subnet_id = "${ aws_subnet.elbpublic-d.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# elbpublic-e association
resource "aws_route_table_association" "elbpublic-e" {
  subnet_id = "${ aws_subnet.elbpublic-e.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# opsprivate-c association
resource "aws_route_table_association" "opsprivate-c" {
  subnet_id = "${ aws_subnet.opsprivate-c.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# etcd-c association
resource "aws_route_table_association" "etcd-c" {
  subnet_id = "${ aws_subnet.etcd-c.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# etcd-d association
resource "aws_route_table_association" "etcd-d" {
  subnet_id = "${ aws_subnet.etcd-d.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# etcd-e association
resource "aws_route_table_association" "etcd-e" {
  subnet_id = "${ aws_subnet.etcd-e.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# controller-c association
resource "aws_route_table_association" "controller-c" {
  subnet_id = "${ aws_subnet.controller-c.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# controller-d association
resource "aws_route_table_association" "controller-d" {
  subnet_id = "${ aws_subnet.controller-d.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# controller-e association
resource "aws_route_table_association" "controller-e" {
  subnet_id = "${ aws_subnet.controller-e.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# node-c association
resource "aws_route_table_association" "node-c" {
  subnet_id = "${ aws_subnet.node-c.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# node-d association
resource "aws_route_table_association" "node-d" {
  subnet_id = "${ aws_subnet.node-d.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# node-e association
resource "aws_route_table_association" "node-e" {
  subnet_id = "${ aws_subnet.node-e.id }"
  route_table_id = "${ aws_route_table.private.id }"
}
