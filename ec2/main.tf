resource "aws_instance" "ec2" {
  ami = "ami-0089b8e98cd95257d"
  instance_type = var.type
  tags = {
    Name = var.component
  }
}

//resource "aws_security_group" "allow_tls" {
//  name        = "${var.component}-${var.env}-sg"
//  description = "Allow TLS inbound traffic"
//
//  ingress {
//    description      = "TLS from VPC"
//    from_port        = 0
//    to_port          = 0
//    protocol         = "-1"
//    cidr_blocks      = ["0.0.0.0/0"]
//  }
//
//  egress {
//    from_port        = 0
//    to_port          = 0
//    protocol         = "-1"
//    cidr_blocks      = ["0.0.0.0/0"]
//    ipv6_cidr_blocks = ["::/0"]
//  }
//
//  tags = {
//    Name = "${var.component}-dev-sg"
//  }
//}
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