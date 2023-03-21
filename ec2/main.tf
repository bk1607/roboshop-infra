data "aws_ami" "ami" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

resource "aws_instance" "ec2" {
  ami = data.aws_ami.ami.id
  instance_type = var.type
  security_groups = [aws_security_group.sg.id[sg_component]]
  tags = {
    Name = var.component
  }
}
resource "aws_security_group" "sg" {
  name = "${var.component}-${var.env}-sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}



resource "aws_route53_record" "records" {
  zone_id = "Z00815241ZW6NBO5CNYD8"
  name    = "${var.component}-dev.devops2023.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.ec2.private_ip]
}

variable "component" {}
variable "type" {}
variable "env" {
  default = "dev"
}
variable "sg_component" {}

