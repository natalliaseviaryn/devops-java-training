provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "id_rsa"
  public_key = tls_private_key.rsa_key.public_key_openssh
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "ubuntu_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.ubuntu_instance_sg.id]
  key_name               = aws_key_pair.my_key_pair.key_name

  user_data_replace_on_change = true
  user_data                   = templatefile("user-data-ubuntu.sh", {
    ssh_private_key = tls_private_key.rsa_key.private_key_pem,
    ssh_public_key = tls_private_key.rsa_key.public_key_openssh,
  })

  tags = {
    Name = "training-terraform-ubuntu"
  }
}

resource "aws_instance" "linux_instance" {
  ami           = data.aws_ami.linux.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.linux_instance_sg.id]
  key_name               = aws_key_pair.my_key_pair.key_name

  user_data_replace_on_change = true
  user_data                   = templatefile("user-data-linux.sh", {
    ssh_public_key = tls_private_key.rsa_key.public_key_openssh,
  })

  tags = {
    Name = "training-terraform-linux"
  }
}