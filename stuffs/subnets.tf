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

# operations private subnet
resource "aws_subnet" "opsprivate-c" {
  vpc_id = "${ aws_vpc.main.id }"
  cidr_block = "${ var.cidr }.10.0/24"
  availability_zone = "us-east-1c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name = "${ var.env }-opsprivate-subnet-c"
    Environment = "${ var.env }"
    Private = "yes"
  }
}
