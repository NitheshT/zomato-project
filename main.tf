provider "aws" {}

variable "project_name" {
  default = "zomato"
}
variable "project_env" {
  default = "prod"
}

variable "instance_type" {
  default = "t2.micro"
}
variable "ami_id" {
  default = "ami-0d13e3e640877b0b9"
}

resource "aws_security_group" "webserver" {

  name        = "${var.project_name}-${var.project_env}-webserver"
  description = "Allow ssh from myip"

  ingress {

    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {

    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name"    = "${var.project_name}-${var.project_env}-webserver"
    "project" = var.project_name
    "env"     = var.project_env
  }
}

resource "aws_instance" "webserver" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "mumbai-region"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data              = file("user_data.sh")
  tags = {
    "Name"    = "${var.project_name}-${var.project_env}-webserver"
    "project" = var.project_name
    "env"     = var.project_env
  }
}
