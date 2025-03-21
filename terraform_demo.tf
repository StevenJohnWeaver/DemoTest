variable "vpc_id" {
  type = string
  default = "Default" #This is not used, remove it.
}

variable "subnet_id" {
  type = string
  default = "Default" #This is not used, remove it.
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" # Changed to a valid CIDR range
  tags = {
    Name = "My-VPC"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24" # Changed to a subnet within the VPC's CIDR range
  tags = {
    Name = "My-Subnet"
  }
}

resource "aws_instance" "my_first_ec2_instance" {
  ami           = "ami-08b5b3a93ed654d19" #Check if this is appropriate for your region.
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id
  tags = {
    Name = "my_first_ec2_instance"
  }
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Restrict this in production!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #Restrict this in production!
  }
}

resource "aws_instance" "my_first_ec2_instance" {
  ami                    = "ami-08b5b3a93ed654d19" #Check AMI for region!
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id             = aws_subnet.my_subnet.id
  tags = {
    Name = "my_first_ec2_instance"
  }
}
