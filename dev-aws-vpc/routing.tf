# private route
resource "aws_route_table" "private" {
  vpc_id = "${ aws_vpc.main.id }"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${ aws_nat_gateway.nat.id }"
  }
  tags {
    Name         = "${ var.env }-private-route"
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
    Name         = "${ var.env }-public-route"
    terraform_id = "${ var.env }-terraform"
  }
}

# opspublic-a association
resource "aws_route_table_association" "opspublic-a" {
  subnet_id      = "${ aws_subnet.opspublic-a.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# elbpublic-a association
resource "aws_route_table_association" "elbpublic-a" {
  subnet_id      = "${ aws_subnet.elbpublic-a.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# elbpublic-b association
resource "aws_route_table_association" "elbpublic-b" {
  subnet_id      = "${ aws_subnet.elbpublic-b.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# elbpublic-c association
resource "aws_route_table_association" "elbpublic-c" {
  subnet_id      = "${ aws_subnet.elbpublic-c.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# opsprivate-a association
resource "aws_route_table_association" "opsprivate-a" {
  subnet_id      = "${ aws_subnet.opsprivate-a.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# etcd-a association
resource "aws_route_table_association" "etcd-a" {
  subnet_id      = "${ aws_subnet.etcd-a.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# etcd-b association
resource "aws_route_table_association" "etcd-b" {
  subnet_id      = "${ aws_subnet.etcd-b.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# etcd-c association
resource "aws_route_table_association" "etcd-c" {
  subnet_id      = "${ aws_subnet.etcd-c.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# controller-a association
resource "aws_route_table_association" "controller-a" {
  subnet_id      = "${ aws_subnet.controller-a.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# controller-b association
resource "aws_route_table_association" "controller-b" {
  subnet_id      = "${ aws_subnet.controller-b.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# controller-c association
resource "aws_route_table_association" "controller-c" {
  subnet_id      = "${ aws_subnet.controller-c.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# node-a association
resource "aws_route_table_association" "node-a" {
  subnet_id      = "${ aws_subnet.node-a.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# node-b association
resource "aws_route_table_association" "node-b" {
  subnet_id      = "${ aws_subnet.node-b.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# node-c association
resource "aws_route_table_association" "node-c" {
  subnet_id      = "${ aws_subnet.node-c.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# db-a association
resource "aws_route_table_association" "db-a" {
  subnet_id      = "${ aws_subnet.db-a.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# db-b association
resource "aws_route_table_association" "db-b" {
  subnet_id      = "${ aws_subnet.db-b.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

# db-c association
resource "aws_route_table_association" "db-c" {
  subnet_id      = "${ aws_subnet.db-c.id }"
  route_table_id = "${ aws_route_table.private.id }"
}

