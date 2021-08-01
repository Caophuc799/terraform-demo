
resource "aws_instance" "web_server" {
  ami = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro" # free tier
  count = "${var.server_count}"
}