resource "aws_instance" "ec2" {
  ami = data.aws_ami.ami.id
  instance_type = var.type
  vpc_security_group_ids = [aws_security_group.sg.id]
  iam_instance_profile = "${var.env}-${var.component}-role"
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
  name    = "${var.component}-${var.env}.devops2023.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.ec2.private_ip]
}

resource "aws_iam_policy" "ssm-policy" {
  name        = "${var.env}-${var.component}-ssm"
  path        = "/"
  description = "${var.env}-${var.component}-ssm"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource" : "arn:aws:ssm:us-east-1:046657053850:parameter/${var.component}*"
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : [
          "ssm:ListInventoryEntries",
          "ssm:DescribeParameters"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "role" {
  name = "${var.env}-${var.component}-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.env}-${var.component}-role"
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.ssm-policy.arn
}