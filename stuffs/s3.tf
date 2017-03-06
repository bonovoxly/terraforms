resource "aws_s3_bucket" "stuffs_bucket" {
    bucket = "${ var.stuffs_bucket_name }"
    force_destroy = true
    acl = "${ var.stuffs_bucket_acl }"
    tags {
        Name = "${ var.stuffs_bucket_name }"
        Environment = "${ var.env }"
    }
}
