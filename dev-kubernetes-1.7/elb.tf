resource "aws_elb" "dev-controller" {
  name               = "${ var.env }-controller-elb"
  security_groups    = ["${ aws_security_group.controller-elb-inbound.id}"]
  subnets            = ["${ data.aws_subnet.elbpublic-a.id  }", "${ data.aws_subnet.elbpublic-b.id  }", "${ data.aws_subnet.elbpublic-c.id  }"]
  instances          = ["${ aws_instance.controller-a.id }", "${ aws_instance.controller-b.id }", "${ aws_instance.controller-c.id }" ]
  internal           = true

  listener {
    instance_port     = 6443
    instance_protocol = "tcp"
    lb_port           = 6443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:6443"
    interval            = 10
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 60

  tags {
    Name = "${ var.env }-kubernetes-controller-elb"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
  }
}

