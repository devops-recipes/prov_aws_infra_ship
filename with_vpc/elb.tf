# WWW Load balancer
resource "aws_elb" "lb_g_www" {
 name = "lb-g-www-${var.install_version}"
 connection_draining = true
 subnets = [
   "${aws_subnet.ship_sn.id}"]
 security_groups = [
   "${aws_security_group.ship_sg.id}"]

 listener {
   lb_port = 443
   lb_protocol = "ssl"
   instance_port = 50001
   instance_protocol = "tcp"
   ssl_certificate_id = "${var.acm_cert_arn}"
 }

 health_check {
   healthy_threshold = 2
   unhealthy_threshold = 2
   timeout = 3
   target = "HTTP:50001/"
   interval = 5
 }

 instances = [
   "${aws_instance.ship_cp_1.id}"
 ]
}

# API Load balancer
resource "aws_elb" "lb_g_api" {
 name = "lb-g-api-${var.install_version}"
 connection_draining = true
 subnets = [
   "${aws_subnet.ship_sn.id}"]
 security_groups = [
   "${aws_security_group.ship_sg.id}"]

 listener {
   lb_port = 443
   lb_protocol = "https"
   instance_port = 50000
   instance_protocol = "http"
   ssl_certificate_id = "${var.acm_cert_arn}"
 }

 health_check {
   healthy_threshold = 2
   unhealthy_threshold = 2
   timeout = 3
   target = "HTTP:50000/"
   interval = 5
 }

 instances = [
   "${aws_instance.ship_cp_1.id}"
 ]
}

# MSG Load balancer
resource "aws_elb" "lb_msg" {
  name = "lb-msg-${var.install_version}"
  idle_timeout = 3600
  connection_draining = true
  connection_draining_timeout = 3600
  subnets = [
    "${aws_subnet.ship_sn.id}"]
  security_groups = [
    "${aws_security_group.ship_sg.id}"]

  listener {
    lb_port = 443
    lb_protocol = "https"
    instance_port = 15672
    instance_protocol = "http"
    ssl_certificate_id = "${var.acm_cert_arn}"
  }

  listener {
    lb_port = 5671
    lb_protocol = "ssl"
    instance_port = 5672
    instance_protocol = "tcp"
    ssl_certificate_id = "${var.acm_cert_arn}"
  }

  listener {
    lb_port = 15671
    lb_protocol = "https"
    instance_port = 15672
    instance_protocol = "http"
    ssl_certificate_id = "${var.acm_cert_arn}"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:15672/"
    interval = 5
  }

  instances = [
    "${aws_instance.ship_cp_1.id}"]
}
