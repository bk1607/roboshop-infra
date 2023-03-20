resource "aws_security_group" "sg" {
  name        = "${var.component}-dev-sg"
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

variable "component" {}

output "sg_names" {
  value = aws_security_group.sg
}