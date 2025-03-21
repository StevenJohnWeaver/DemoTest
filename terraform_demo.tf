provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_first_ec2_instance" {
  ami = "ami-08b5b3a93ed654d19" 
  instance_type = "t2.micro" # Got to https://aws.amazon.com/ec2/instance-types/t2/ for a full T2 instance type list.
  
  tags = {
    Name = "my_first_ec2_instance"
  }
}
