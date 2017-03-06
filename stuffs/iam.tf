# openvpn instance profile
resource "aws_iam_instance_profile" "openvpn" {
  name = "${ var.env }-openvpn-profile"
  roles = ["${ aws_iam_role.openvpn.name }"]
}

# example instance profile
resource "aws_iam_instance_profile" "example" {
  name = "${ var.env }-example-profile"
  roles = ["${ aws_iam_role.example.name }"]
}

# openvpn IAM role
resource "aws_iam_role" "openvpn" {
  name = "${ var.env }-openvpn-role"
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

# example IAM role
resource "aws_iam_role" "example" {
  name = "${ var.env }-example-role"
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
