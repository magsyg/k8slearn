resource "aws_security_group" "control_plane_sg" {
  name   = "${var.name_prefix}-controlplane-sg"
  vpc_id = var.main_vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ingress_loadbalancer_frontend" {
  // can get input on frontend port, from anywhere
  security_group_id = aws_security_group.control_plane_sg.id
  ip_protocol       = "tcp"
  from_port         = "6443"
  to_port           =  "6443"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "engress_loadbalancer_frontend" {
  // can send to frontend security group on frontend port
  security_group_id = aws_security_group.control_plane_sg.id
  ip_protocol       = "tcp"
  from_port         =  "6443"
  to_port           =  "6443"
  cidr_ipv4         = "0.0.0.0/0"
}
