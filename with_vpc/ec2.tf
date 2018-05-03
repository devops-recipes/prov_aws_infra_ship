# Control Plane
resource "aws_instance" "ship_cp_1" {
  ami = "${var.ami_us_east_1_ubuntu1604}"
  availability_zone = "${var.avl_zone}"
  instance_type = "${var.in_type_cp}"
  key_name = "${var.aws_key_name}"
  subnet_id = "${aws_subnet.ship_sn.id}"

  vpc_security_group_ids = [
    "${aws_security_group.ship_sg.id}"]

  root_block_device {
    volume_type = "io1"
    volume_size = 50
    delete_on_termination = true
  }

  tags = {
    Name = "ship_cp_1_${var.install_version}"
  }
}

output "ship_cp_1_priv_ip" {
  value = "${aws_instance.ship_cp_1.private_ip}"
}

output "ship_cp_1_pub_ip" {
  value = "${aws_instance.ship_cp_1.public_ip}"
}

# Build Plane Shared Pool Ubuntu 16.04 x86 machine
resource "aws_instance" "ship_shr_pl_x86_u1604_01" {
  ami = "${var.ami_us_east_1_ubuntu1604}"
  availability_zone = "${var.avl_zone}"
  instance_type = "${var.in_type_bp}"
  key_name = "${var.aws_key_name}"
  subnet_id = "${aws_subnet.ship_sn.id}"

  vpc_security_group_ids = [
    "${aws_security_group.ship_sg.id}"]

  root_block_device {
    volume_type = "io1"
    volume_size = 100
    delete_on_termination = true
  }

  tags = {
    Name = "ship_shr_pl_x86_u1604_01_${var.install_version}"
  }
}

output "ship_shr_pl_x86_u1604_01_priv_ip" {
  value = "${aws_instance.ship_shr_pl_x86_u1604_01.private_ip}"
}

output "ship_shr_pl_x86_u1604_01_pub_ip" {
  value = "${aws_instance.ship_shr_pl_x86_u1604_01.public_ip}"
}
