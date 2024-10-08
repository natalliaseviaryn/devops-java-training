resource "aws_security_group" "linux_instance_sg" {
  name        = "linux_instance_sg"
  description = "EC2 Amazon Linux should not have access to the Internet, but must have outgoing and incoming access: ICMP, TCP/22, TCP/80, TCP/443 only on the local network where EC2 Ubuntu, EC2 Amazon Linux is located."
  vpc_id            = data.aws_vpc.default.id
  tags = {
    Name = "linux_instance_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "linux_allow_icmp" {
  security_group_id = aws_security_group.linux_instance_sg.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"
}

resource "aws_vpc_security_group_ingress_rule" "linux_allow_tcp_22" {
  security_group_id = aws_security_group.linux_instance_sg.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_ingress_rule" "linux_allow_tcp_80" {
  security_group_id = aws_security_group.linux_instance_sg.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "linux_allow_tcp_443" {
  security_group_id = aws_security_group.linux_instance_sg.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "linux_allow_outgoing_icmp" {
  security_group_id = aws_security_group.linux_instance_sg.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"
}

resource "aws_vpc_security_group_egress_rule" "linux_allow_outgoing_tcp_22" {
  security_group_id = aws_security_group.linux_instance_sg.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "linux_allow_outgoing_tcp_80" {
  security_group_id = aws_security_group.linux_instance_sg.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "linux_allow_outgoing_tcp_443" {
  security_group_id = aws_security_group.linux_instance_sg.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
