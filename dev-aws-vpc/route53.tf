resource "aws_route53_zone" "zone" {
  name   = "${ var.dns }."
  vpc_id = "${ aws_vpc.main.id }"
  tags {
    Environment = "${ var.env }"
  }
}

