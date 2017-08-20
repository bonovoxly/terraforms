# cfssl instance profile
resource "aws_iam_instance_profile" "cfssl" {
  name = "${ var.env }-cfssl-profile"
  role = "${ aws_iam_role.cfssl.name }"
}

# etcd instance profile
resource "aws_iam_instance_profile" "etcd" {
  name = "${ var.env }-etcd-profile"
  role = "${ aws_iam_role.etcd.name }"
}

# controller instance profile
resource "aws_iam_instance_profile" "controller" {
  name = "${ var.env }-controller-profile"
  role = "${ aws_iam_role.controller.name }"
}

# node instance profile
resource "aws_iam_instance_profile" "node" {
  name = "${ var.env }-node-profile"
  role = "${ aws_iam_role.node.name }"
}

# cfssl IAM role
resource "aws_iam_role" "cfssl" {
  name               = "${ var.env }-cfssl-role"
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

# etcd IAM role
resource "aws_iam_role" "etcd" {
  name               = "${ var.env }-etcd-role"
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

# controller IAM role
resource "aws_iam_role" "controller" {
  name               = "${ var.env }-controller-role"
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

# node IAM role
resource "aws_iam_role" "node" {
  name               = "${ var.env }-node-role"
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

# controller IAM role policy
resource "aws_iam_role_policy" "controller" {
  name   = "controller_policy"
  role   = "${ aws_iam_role.controller.id }"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["ec2:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["elasticloadbalancing:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["route53:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::kubernetes-*"
      ]
    }
  ]
}
EOF
}

# node IAM role policy
resource "aws_iam_role_policy" "node" {
  name   = "node_policy"
  role   = "${ aws_iam_role.node.id }"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::kubernetes-*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:AttachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:DetachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": ["route53:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:BatchGetImage"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

