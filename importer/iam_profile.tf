
resource "aws_iam_instance_profile" "aws_internal1_role" {
  name = "aws_internal1_role"
  roles = ["aws_internal1_role"]
}
resource "aws_iam_instance_profile" "aws_internal2_role" {
  name = "aws_internal2_role"
  roles = ["aws_internal2_role"]
}
resource "aws_iam_instance_profile" "demo-db1-profile" {
  name = "demo-db1-profile"
  roles = ["demo-assume-role"]
}
resource "aws_iam_instance_profile" "demo-web1-profile" {
  name = "demo-web1-profile"
  roles = ["demo-assume-role"]
}
resource "aws_iam_instance_profile" "internal1_role" {
  name = "internal1_role"
  roles = ["internal1_role"]
}
resource "aws_iam_instance_profile" "internal2_role" {
  name = "internal2_role"
  roles = ["internal2_role"]
}
resource "aws_iam_instance_profile" "natinstance_role" {
  name = "natinstance_role"
  roles = ["natinstance_role"]
}
resource "aws_iam_instance_profile" "openvpn_role" {
  name = "openvpn_role"
  roles = ["openvpn_role"]
}
