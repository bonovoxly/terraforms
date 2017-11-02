resource "aws_route53_record" "kube-controlplane" {
   zone_id = "${ data.aws_route53_zone.zone.id }"
   name = "${ var.env }-controller.${ var.dns }"
   type = "CNAME"
   ttl = "60"
   records = ["${ aws_elb.dev-controller.dns_name }"]
}

resource "aws_route53_record" "cfssl" {
   zone_id = "${ data.aws_route53_zone.zone.id }"
   name    = "${ aws_instance.cfssl.tags.Name }.${ var.dns }"
   type    = "A"
   ttl     = "300"
   records = ["${ aws_instance.cfssl.private_ip }"]
}

resource "aws_route53_record" "etcd-a" {
   zone_id = "${ data.aws_route53_zone.zone.id }"
   name    = "${ aws_instance.etcd-a.tags.Name }.${ var.dns }"
   type    = "A"
   ttl     = "300"
   records = ["${ aws_instance.etcd-a.private_ip }"]
}

resource "aws_route53_record" "etcd-b" {
   zone_id = "${ data.aws_route53_zone.zone.id }"
   name    = "${ aws_instance.etcd-b.tags.Name }.${ var.dns }"
   type    = "A"
   ttl     = "300"
   records = ["${ aws_instance.etcd-b.private_ip }"]
}

resource "aws_route53_record" "etcd-c" {
   zone_id = "${ data.aws_route53_zone.zone.id }"
   name    = "${ aws_instance.etcd-c.tags.Name }.${ var.dns }"
   type    = "A"
   ttl     = "300"
   records = ["${ aws_instance.etcd-c.private_ip }"]
}

resource "aws_route53_record" "controller-a" {
   zone_id = "${ data.aws_route53_zone.zone.id }"
   name    = "${ aws_instance.controller-a.tags.Name }.${ var.dns }"
   type    = "A"
   ttl     = "300"
   records = ["${ aws_instance.controller-a.private_ip }"]
}

resource "aws_route53_record" "controller-b" {
   zone_id = "${ data.aws_route53_zone.zone.id }"
   name    = "${ aws_instance.controller-b.tags.Name }.${ var.dns }"
   type    = "A"
   ttl     = "300"
   records = ["${ aws_instance.controller-b.private_ip }"]
}

resource "aws_route53_record" "controller-c" {
   zone_id = "${ data.aws_route53_zone.zone.id }"
   name    = "${ aws_instance.controller-c.tags.Name }.${ var.dns }"
   type    = "A"
   ttl     = "300"
   records = ["${ aws_instance.controller-c.private_ip }"]
}
