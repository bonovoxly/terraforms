# AWS Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = "${ aws_vpc.main.id }"
  tags {
    Name         = "${ var.env }-igw"
    terraform_id = "${ var.env }-terraform"
    Environment  = "${ var.env }"
  }
}

# AWS Elastic IP
resource "aws_eip" "nat" {
  vpc = true
}

# AWS NAT Gateway
resource "aws_nat_gateway" "nat" {
  depends_on = [
    "aws_eip.nat",
    "aws_internet_gateway.main"
  ]
  allocation_id = "${ aws_eip.nat.id }"
  subnet_id     = "${ aws_subnet.opspublic-a.id }"
}
