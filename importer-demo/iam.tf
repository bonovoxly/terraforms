# web1 instance profile
resource "aws_iam_instance_profile" "web1" {
  name = "${ var.env }-web1-profile"
  roles = ["${ aws_iam_role.assumerole.name }"]
}

# db1 instance profile
resource "aws_iam_instance_profile" "db1" {
  name = "${ var.env }-db1-profile"
  roles = ["${ aws_iam_role.assumerole.name }"]
}

# openvpn IAM role
resource "aws_iam_role" "assumerole" {
  name = "${ var.env }-assume-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
