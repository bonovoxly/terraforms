# vmimage variables

variable "environment" {
  type = "string"
  default = "vmimage"
}

variable "base_image" {
  type = "string"
  default = "DEFAULT"
}

variable "sshkey" {
  type = "string"
  default = "~/.ssh/id_rsa.pub"
}
