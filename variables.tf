variable "key_name" {
  description = "key-pair name prev generated"
  type = string
  default = "my-ec2-key"
}

variable "region" {
  description = "Value of the region to deploy resources"
  type = string
  default = "us-east-1"
}

variable "ec2_ami" {
  description = "Ubunqtu Server 20.04 LTS 64-bit - us-east-1 (N.Virginia)"
  type = string
  default = "ami-0c4f7023847b90238"
}

variable "instance_type" {
    description = "free-tier instance type"
    type = string
    default = "t2.micro"
}
