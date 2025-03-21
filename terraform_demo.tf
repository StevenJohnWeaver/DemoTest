variable "vpc_id" {
  type = string
  default = "vpc-07b06a38cc5697c2c"
}

variable "security_group_id" {
  type = string
  default = "sg-0d6b3246daec36e9c"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_first_ec2_instance" {
  ami = "ami-08b5b3a93ed654d19" 
  instance_type = "t2.micro" # Got to https://aws.amazon.com/ec2/instance-types/t2/ for a full T2 instance type list.
  vpc_security_group_ids = [var.security_group_id]
  vpc_id                 = var.vpc_id
  tags = {
    Name = "my_first_ec2_instance"
  }
}
