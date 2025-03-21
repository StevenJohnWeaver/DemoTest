variable "vpc_id" {
  type = string
  default = "Default"
}

variable "subnet_id" {
  type = string
  default = "Default"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "102.0.0.0/16"
  tags = {
    Name = "My-VPC"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "102.0.0.0/24"
  tags = {
    Name = "My-Subnet"
  }
}

resource "aws_instance" "my_first_ec2_instance" {
  ami = "ami-08b5b3a93ed654d19" 
  instance_type = "t2.micro" # Got to https://aws.amazon.com/ec2/instance-types/t2/ for a full T2 instance type list.
  vpc_id = aws_vpc.my_vpc.id
  subnet_id = aws_subnet.my_subnet.id
  tags = {
    Name = "my_first_ec2_instance"
  }
}
