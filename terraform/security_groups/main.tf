resource "aws_security_group" "control_plane_sg" {
  name   = "${var.name_prefix}-controlplane-sg"
  vpc_id = var.main_vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ingress_controlplane_https" {
  // can get input on frontend port, from anywhere
  security_group_id = aws_security_group.control_plane_sg.id
  ip_protocol       = "tcp"
  from_port         = "6443"
  to_port           =  "6443"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_controlplane_ssh" {
  // can get input on frontend port, from anywhere
  security_group_id = aws_security_group.control_plane_sg.id
  ip_protocol       = "ssh"
  from_port         = "22"
  to_port           =  "22"
  cidr_ipv4         = "0.0.0.0/0"
}
