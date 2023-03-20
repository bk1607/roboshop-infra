data "aws_ami" "ami" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

resource "aws_instance" "ec2" {
  ami = data.aws_ami.ami.image_id
  instance_type = var.type
  security_groups = [aws_security_group.allow_tls["${var.component}-${var.env}-sg"].id]
  tags = {
    Name = var.component
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "${var.component}-${var.env}-sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "allow all"
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
    Name = "${var.component}-dev-sg"
  }
}
//resource "aws_route53_record" "records" {
//  zone_id = "Z00815241ZW6NBO5CNYD8"
//  name    = "${var.component}-${var.env}.devops2023.online"
//  type    = "A"
//  ttl     = 30
//  records = [aws_instance.ec2.private_ip]
//}

variable "component" {}
variable "type" {}
variable "env" {
  default = "dev"
}