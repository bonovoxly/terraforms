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

# opsprivate-c association
resource "aws_route_table_association" "opsprivate-c" {
  subnet_id = "${ aws_subnet.opsprivate-c.id }"
  route_table_id = "${ aws_route_table.private.id }"
}
