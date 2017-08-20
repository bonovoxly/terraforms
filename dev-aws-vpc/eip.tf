resource "aws_eip" "eip" {
  vpc           = true
  instance   = "${ aws_instance.openvpn.id }"
}
