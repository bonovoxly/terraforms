# cfssl data volume
resource "aws_ebs_volume" "cfssl" {
  availability_zone = "${ aws_instance.cfssl.availability_zone }"
  encrypted         = true
  size              = 10
  tags {
    Name = "${ var.env }-cfssl-ebs"
  }
}

# cfssl attach volume
resource "aws_volume_attachment" "cfssl" {
  skip_destroy = true
  device_name  = "/dev/sde"
  volume_id    = "${ aws_ebs_volume.cfssl.id }"
  instance_id  = "${ aws_instance.cfssl.id }"
}

# etcd-a data volume
resource "aws_ebs_volume" "etcd-a" {
  availability_zone = "${element(aws_instance.etcd-a.*.availability_zone, count.index)}"
  count             = 1
  encrypted         = true
  size              = 20
  tags {
    Name = "${ var.env }-etcd-a-${count.index}-ebs"
  }
}

# etcd-a attach volume
resource "aws_volume_attachment" "etcd-a" {
  skip_destroy = true
  count        = 1
  device_name  = "/dev/sde"
  volume_id    = "${element(aws_ebs_volume.etcd-a.*.id, count.index)}"
  instance_id  = "${element(aws_instance.etcd-a.*.id, count.index)}"
}

# etcd-b data volume
resource "aws_ebs_volume" "etcd-b" {
  availability_zone = "${element(aws_instance.etcd-b.*.availability_zone, count.index)}"
  count             = 1
  encrypted         = true
  size              = 20
  tags {
    Name = "${ var.env }-etcd-b-${count.index}-ebs"
  }
}

# etcd-b attach volume
resource "aws_volume_attachment" "etcd-b" {
  skip_destroy = true
  count        = 1
  device_name  = "/dev/sde"
  volume_id    = "${element(aws_ebs_volume.etcd-b.*.id, count.index)}"
  instance_id  = "${element(aws_instance.etcd-b.*.id, count.index)}"
}

# etcd-c data volume
resource "aws_ebs_volume" "etcd-c" {
  availability_zone = "${element(aws_instance.etcd-c.*.availability_zone, count.index)}"
  count             = 1
  encrypted         = true
  size              = 20
  tags {
    Name = "${ var.env }-etcd-c-${count.index}-ebs"
  }
}

# etcd-c attach volume
resource "aws_volume_attachment" "etcd-c" {
  skip_destroy = true
  count        = 1
  device_name  = "/dev/sde"
  volume_id    = "${element(aws_ebs_volume.etcd-c.*.id, count.index)}"
  instance_id  = "${element(aws_instance.etcd-c.*.id, count.index)}"
}

# controller-a data volume
resource "aws_ebs_volume" "controller-a" {
  availability_zone = "${element(aws_instance.controller-a.*.availability_zone, count.index)}"
  count             = 1
  encrypted         = true
  size              = 20
  tags {
    Name = "${ var.env }-controller-a-${count.index}-ebs"
  }
}

# controller-a attach volume
resource "aws_volume_attachment" "controller-a" {
  skip_destroy = true
  count        = 1
  device_name  = "/dev/sde"
  volume_id    = "${element(aws_ebs_volume.controller-a.*.id, count.index)}"
  instance_id  = "${element(aws_instance.controller-a.*.id, count.index)}"
}

# controller-b data volume
resource "aws_ebs_volume" "controller-b" {
  availability_zone = "${element(aws_instance.controller-b.*.availability_zone, count.index)}"
  count             = 1
  encrypted         = true
  size              = 20
  tags {
    Name = "${ var.env }-controller-b-${count.index}-ebs"
  }
}

# controller-b attach volume
resource "aws_volume_attachment" "controller-b" {
  skip_destroy = true
  count        = 1
  device_name  = "/dev/sde"
  volume_id    = "${element(aws_ebs_volume.controller-b.*.id, count.index)}"
  instance_id  = "${element(aws_instance.controller-b.*.id, count.index)}"
}

# controller-c data volume
resource "aws_ebs_volume" "controller-c" {
  availability_zone = "${element(aws_instance.controller-c.*.availability_zone, count.index)}"
  count             = 1
  encrypted         = true
  size              = 20
  tags {
    Name = "${ var.env }-controller-c-${count.index}-ebs"
  }
}

# controller-c attach volume
resource "aws_volume_attachment" "controller-c" {
  skip_destroy = true
  count        = 1
  device_name  = "/dev/sde"
  volume_id    = "${element(aws_ebs_volume.controller-c.*.id, count.index)}"
  instance_id  = "${element(aws_instance.controller-c.*.id, count.index)}"
}
