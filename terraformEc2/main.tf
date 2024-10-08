provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "ubuntu_instance_2" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.ubuntu_instance_sg.id]

  user_data_replace_on_change = true
  user_data = file("user-data.sh")

  tags      = {
    Name = "training-terraform-ubuntu"
  }
}

resource "aws_instance" "linux_instance_2" {
  ami           = "ami-0fff1b9a61dec8a5f"
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    aws_security_group.linux_instance_sg.id
  ]

  tags = {
    Name = "training-terraform-linux"
  }
}