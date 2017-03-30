
resource "aws_nat_gateway" "nat-08dc8647c5363b4c6" {
  depends_on = [
    "aws_eip.eipalloc-b33faf82",
    "aws_internet_gateway.igw-bd849fda"
  ]
  allocation_id = "eipalloc-b33faf82"
  subnet_id = "subnet-35646818"
}
