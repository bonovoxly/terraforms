
resource "aws_route53_record" "ZWC6VV9MH3RSY_demoawsinternal_NS" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "demo.aws.internal."
  type = "NS"
  ttl = "172800"
  records = ["ns-1536.awsdns-00.co.uk.","ns-0.awsdns-00.com.","ns-1024.awsdns-00.org.","ns-512.awsdns-00.net."]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_demoawsinternal_SOA" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "demo.aws.internal."
  type = "SOA"
  ttl = "900"
  records = ["ns-1536.awsdns-00.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY__sip_tlsdemoawsinternal_SRV" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "_sip._tls.demo.aws.internal."
  type = "SRV"
  ttl = "300"
  records = ["100 1 443 sipdir.online.lync.com"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_aaademoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "aaa.demo.aws.internal."
  type = "A"
  ttl = "60"
  records = ["10.148.1.10","10.148.1.11","10.148.1.12"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_elasticsearchdocker-elkdefaultdemoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "elasticsearch.docker-elk.default.demo.aws.internal."
  type = "A"
  ttl = "299"
  records = ["10.148.2.156"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_kibanadocker-elkdefaultdemoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "kibana.docker-elk.default.demo.aws.internal."
  type = "A"
  ttl = "299"
  records = ["10.148.3.245"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_logstashdocker-elkdefaultdemoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "logstash.docker-elk.default.demo.aws.internal."
  type = "A"
  ttl = "299"
  records = ["10.148.2.47"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_nginxdocker-elkdefaultdemoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "nginx.docker-elk.default.demo.aws.internal."
  type = "A"
  ttl = "299"
  records = ["10.148.3.168"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-0-89demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-0-89.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.0.89"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-111demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-111.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.111"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-112demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-112.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.112"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-140demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-140.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.140"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-147demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-147.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.147"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-155demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-155.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.155"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-156demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-156.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.156"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-161demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-161.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.161"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-17demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-17.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.17"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-185demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-185.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.185"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-194demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-194.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.194"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-198demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-198.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.198"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-210demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-210.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.210"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-211demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-211.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.211"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-219demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-219.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.219"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-225demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-225.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.225"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-31demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-31.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.31"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-33demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-33.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.33"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-47demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-47.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.47"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-49demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-49.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.49"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-51demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-51.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.51"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-58demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-58.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.58"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-90demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-90.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.90"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-2-97demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-2-97.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.2.97"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-114demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-114.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.114"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-118demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-118.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.118"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-168demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-168.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.168"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-210demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-210.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.210"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-229demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-229.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.229"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-241demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-241.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.241"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-243demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-243.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.243"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-245demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-245.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.245"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-25demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-25.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.25"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-42demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-42.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.42"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-58demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-58.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.58"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-63demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-63.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.63"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-81demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-81.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.81"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-84demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-84.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.84"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-9demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-9.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.9"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_ip-10-148-3-98demoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "ip-10-148-3-98.demo.aws.internal."
  type = "A"
  ttl = "600"
  records = ["10.148.3.98"]
}
resource "aws_route53_record" "ZWC6VV9MH3RSY_xyzdemoawsinternal_A" {
  zone_id = "ZWC6VV9MH3RSY"
  name = "xyz.demo.aws.internal."
  type = "A"
  ttl = "300"
  records = ["1.2.3.4","5.6.7.8"]
}
