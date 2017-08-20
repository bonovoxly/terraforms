resource "aws_efs_file_system" "kubernetes" {
  creation_token = "${ var.env }-kubernetes-efs"

  tags {
    Name         = "${ var.env }-kubernetes-efs"
    terraform_id = "${ var.env }-terraform"
    Environment  = "${ var.env }"
    Role         = "efs"
  }
}

resource "aws_efs_mount_target" "kubernetes" {
  file_system_id  = "${ aws_efs_file_system.kubernetes.id }"
  subnet_id       = "${data.aws_subnet.opsprivate-a.id }"
  security_groups = ["${aws_security_group.efs.id}"]
}
