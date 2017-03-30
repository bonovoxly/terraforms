resource "aws_s3_bucket" "demo_bucket" {
    bucket = "${ var.demo_bucket_name }"
    force_destroy = true
    tags {
        Name = "${ var.demo_bucket_name }"
        Environment = "${ var.env }"
    }
}
