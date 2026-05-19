resource "aws_security_group" "web_sg" {
  name = "terraform-ec2-lab-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {

  ami = "ami-05ffe3c48a9991133"
  instance_type = var.instance_type

  associate_public_ip_address = true

  user_data_replace_on_change = true

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = file("user_data.sh")

  tags = {
    Name = "terraform-ec2-lab"
  }
}