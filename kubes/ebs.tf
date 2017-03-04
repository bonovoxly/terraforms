# cfssl data volume
resource "aws_ebs_volume" "cfssl" {
  availability_zone = "${ aws_instance.cfssl.availability_zone }"
  encrypted = true
  size = 10
  tags {
    Name = "${ var.env }-cfssl-ebs"
  }
}

# cfssl attach volume
resource "aws_volume_attachment" "cfssl" {
  skip_destroy = true
  device_name = "/dev/sde"
  volume_id = "${ aws_ebs_volume.cfssl.id }"
  instance_id = "${ aws_instance.cfssl.id }"
}

# etcd-c data volume
resource "aws_ebs_volume" "etcd-c" {
  availability_zone = "${element(aws_instance.etcd-c.*.availability_zone, count.index)}"
  count = 1
  encrypted = true
  size = 20
  tags {
    Name = "${ var.env }-etcd-c-${count.index}-ebs"
  }
}

# etcd-c attach volume
resource "aws_volume_attachment" "etcd-c" {
  skip_destroy = true
  count = 1
  device_name = "/dev/sde"
  volume_id = "${element(aws_ebs_volume.etcd-c.*.id, count.index)}"
  instance_id = "${element(aws_instance.etcd-c.*.id, count.index)}"
}

# etcd-d data volume
resource "aws_ebs_volume" "etcd-d" {
  availability_zone = "${element(aws_instance.etcd-d.*.availability_zone, count.index)}"
  count = 1
  encrypted = true
  size = 20
  tags {
    Name = "${ var.env }-etcd-d-${count.index}-ebs"
  }
}

# etcd-d attach volume
resource "aws_volume_attachment" "etcd-d" {
  skip_destroy = true
  count = 1
  device_name = "/dev/sde"
  volume_id = "${element(aws_ebs_volume.etcd-d.*.id, count.index)}"
  instance_id = "${element(aws_instance.etcd-d.*.id, count.index)}"
}

# etcd-e data volume
resource "aws_ebs_volume" "etcd-e" {
  availability_zone = "${element(aws_instance.etcd-e.*.availability_zone, count.index)}"
  count = 1
  encrypted = true
  size = 20
  tags {
    Name = "${ var.env }-etcd-e-${count.index}-ebs"
  }
}

# etcd-e attach volume
resource "aws_volume_attachment" "etcd-e" {
  skip_destroy = true
  count = 1
  device_name = "/dev/sde"
  volume_id = "${element(aws_ebs_volume.etcd-e.*.id, count.index)}"
  instance_id = "${element(aws_instance.etcd-e.*.id, count.index)}"
}

# controller-c data volume
resource "aws_ebs_volume" "controller-c" {
  availability_zone = "${element(aws_instance.controller-c.*.availability_zone, count.index)}"
  count = 1
  encrypted = true
  size = 20
  tags {
    Name = "${ var.env }-controller-c-${count.index}-ebs"
  }
}

# controller-c attach volume
resource "aws_volume_attachment" "controller-c" {
  skip_destroy = true
  count = 1
  device_name = "/dev/sde"
  volume_id = "${element(aws_ebs_volume.controller-c.*.id, count.index)}"
  instance_id = "${element(aws_instance.controller-c.*.id, count.index)}"
}

# controller-d data volume
resource "aws_ebs_volume" "controller-d" {
  availability_zone = "${element(aws_instance.controller-d.*.availability_zone, count.index)}"
  count = 1
  encrypted = true
  size = 20
  tags {
    Name = "${ var.env }-controller-d-${count.index}-ebs"
  }
}

# controller-d attach volume
resource "aws_volume_attachment" "controller-d" {
  skip_destroy = true
  count = 1
  device_name = "/dev/sde"
  volume_id = "${element(aws_ebs_volume.controller-d.*.id, count.index)}"
  instance_id = "${element(aws_instance.controller-d.*.id, count.index)}"
}

# controller-e data volume
resource "aws_ebs_volume" "controller-e" {
  availability_zone = "${element(aws_instance.controller-e.*.availability_zone, count.index)}"
  count = 1
  encrypted = true
  size = 20
  tags {
    Name = "${ var.env }-controller-e-${count.index}-ebs"
  }
}

# controller-e attach volume
resource "aws_volume_attachment" "controller-e" {
  skip_destroy = true
  count = 1
  device_name = "/dev/sde"
  volume_id = "${element(aws_ebs_volume.controller-e.*.id, count.index)}"
  instance_id = "${element(aws_instance.controller-e.*.id, count.index)}"
}
