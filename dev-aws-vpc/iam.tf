# openvpn instance profile
resource "aws_iam_instance_profile" "openvpn" {
  name = "${ var.env }-openvpn-profile"
  role = "${ aws_iam_role.openvpn.name }"
}

# openvpn IAM role
resource "aws_iam_role" "openvpn" {
  name               = "${ var.env }-openvpn-role"
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

