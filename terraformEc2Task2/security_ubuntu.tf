resource "aws_security_group" "ubuntu_instance_sg" {
  name        = "ubuntu_instance_sg"
  description = "EC2 Ubuntu must have Internet access, there must be incoming access: ICMP, TCP/22, 80, 443, and any outgoing access."

  tags = {
    Name = "ubuntu_instance_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ubuntu_allow_icmp" {
  security_group_id = aws_security_group.ubuntu_instance_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"
}

resource "aws_vpc_security_group_ingress_rule" "ubuntu_allow_tcp_22" {
  security_group_id = aws_security_group.ubuntu_instance_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "ubuntu_allow_tcp_80" {
  security_group_id = aws_security_group.ubuntu_instance_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ubuntu_allow_tcp_443" {
  security_group_id = aws_security_group.ubuntu_instance_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "ubuntu_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ubuntu_instance_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}