# edit these bucket settings to make them private

data "template_file" "stuffs_bucket_policy" {
    template = "${file("${path.module}/policy.json")}"

    vars {
        bucket_name = "${var.stuffs_bucket_name}"
    }
}

resource "aws_s3_bucket" "stuffs_bucket" {
    bucket = "${ var.stuffs_bucket_name }"
    force_destroy = true
    acl = "${ var.stuffs_bucket_acl }"
    policy = "${data.template_file.stuffs_bucket_policy.rendered}"
    website {
        index_document = "index.html"
        error_document = "error.html"
    }
    tags {
        Name = "${ var.stuffs_bucket_name }"
        Environment = "${ var.env }"
    }
}
