resource "aws_instance" "web_server" {
  ami = "${lookup(var.webserver_amis, var.aws_region)}"
  instance_type = "t2.micro" # free tier

  # Implicit: It depend on aws_default_subnet. It's going to create default subnet first
  subnet_id = "${aws_default_subnet.demo_default_subnet.id}"

  # Explicit
  depends_on = [
    aws_s3_bucket.demo-bins
  ]
}

output "webserver_public_ip" {
  value = "${aws_instance.web_server.public_ip}"
}

