data "aws_ami" "ami" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

resource "aws_instance" "ec2" {
  ami = data.aws_ami.ami.image_id
  instance_type = var.type
  security_groups = [sg_id]
  tags = {
    Name = var.component
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
variable "sg_id" {}