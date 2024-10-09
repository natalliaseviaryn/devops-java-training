provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
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

  user_data_replace_on_change = true
  user_data                   = file("user-data.sh")

  tags = {
    Name = "training-terraform-ubuntu"
  }
}

resource "aws_instance" "linux_instance" {
  ami           = data.aws_ami.linux.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    aws_security_group.linux_instance_sg.id
  ]

  tags = {
    Name = "training-terraform-linux"
  }
}