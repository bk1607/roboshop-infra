data "aws_caller_identity" "current"{

}
data "aws_ami" "ami" {
  most_recent = true
  name_regex = "ansible-practice"
  owners = [data.aws_caller_identity.current.account_id]
}

resource "aws_instance" "ec2" {
  ami = data.aws_ami.ami.id
  instance_type = var.type
  vpc_security_group_ids = [aws_security_group.sg.id]

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

resource "null_resource" "commands" {
  provisioner "remote-exec" {
    connection {
      host = aws_instance.ec2.public_ip
      user = "centos"
      password = "DevOps321"
    }
    inline = [
      "ansible-pull -i localhost, -U https://github.com/bk1607/ansible-roboshop roboshop.yml -e role_name=${var.component}"
    ]
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

variable "password" {}