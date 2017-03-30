
resource "aws_route53_zone" "demo-aws-internal" {
  lifecycle {
    ignore_changes = ["comment"]
}
  name = "demo.aws.internal."
  vpc_id = "vpc-aba548cf"
}
