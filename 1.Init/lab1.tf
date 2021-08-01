# define provider
provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}

#define resource
resource "aws_instance" "backend" {
  ami = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro" # free tier
}