terraform {
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2" {
  ami = var.ec2_ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.main.id]


  tags = {
    Name = "Haris-EC2"
  }

  provisioner "file" {
    source      = "html"
    destination = "/home/ubuntu"

    connection {
        type        = "ssh"
        host        = aws_instance.ec2.public_ip
        user        = "ubuntu"
        private_key = file("/home/haris/PAT/my-ec2-key.pem") // the path to where the key is stored relative to this file
    }
  }
  user_data = file("${path.module}/init_webserver.sh")
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# Security Group Configs
resource "aws_security_group" "main" {
  vpc_id      = aws_default_vpc.default.id

  egress = [ {
    cidr_blocks = [ "0.0.0.0/0", ]
    description = ""
    from_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "-1"
    security_groups = []
    self = false
    to_port = 0
  } ]

  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0", ]
    description = ""
    from_port = 22
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 22
  }, 
   {
    cidr_blocks = [ "0.0.0.0/0", ]
    description = ""
    from_port = 80
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 80
  } ]
}

output "EC2-IP" {
  value = aws_instance.ec2.public_ip
}