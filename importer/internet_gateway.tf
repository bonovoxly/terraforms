
# AWS Internet Gateway
resource "aws_internet_gateway" "igw-51026836" {
  vpc_id = "vpc-a31db4c5"
  tags {
  }
}
# AWS Internet Gateway
resource "aws_internet_gateway" "igw-bd849fda" {
  vpc_id = "vpc-e90b2a8f"
  tags {
"terraform_id" = "demo-terraform"
"Environment" = "demo"
"Name" = "demo-igw"
  }
}
