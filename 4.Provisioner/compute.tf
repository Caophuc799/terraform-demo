resource "aws_instance" "web_server" {
  ami = "${lookup(var.webserver_amis, var.aws_region)}"
  instance_type = "t2.micro" # free tier

  subnet_id = "${aws_default_subnet.demo_default_subnet.id}"

  depends_on = [
    aws_s3_bucket.demo-bins
  ]

  key_name = "${aws_key_pair.deployer-keypair.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.web_server_sec_group.id}" ]


  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  # install apache
  provisioner "remote-exec" {
    inline = [
    /* It use if we don't use load file bootstrap.sh
      "sudo yum install -y httpd",
      "sudo service httpd start",
      "sudo groupadd www",
      "sudo usermod -a -G www ec2-user",
      "sudo usermod -a -G www apache",
      "sudo chown -R apache:www /var/www",
      "sudo chmod 770 -R /var/www"
    */
    /* It use for bootstrap.sh file */
      "chmod +x /tmp/bootstrap.sh",
      "/tmp/bootstrap.sh"
    ]
  }

  # upload file to apache
  provisioner "file" {
    source = "demo.index.html"
    destination = "/var/www/html/index.html"
  }

  # set connection to provisioner to connect to ec2
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file("${path.module}/aws_rsa")}"
    host = "${aws_instance.web_server.public_ip}"
  }
}

output "webserver_public_ip" {
  value = "${aws_instance.web_server.public_ip}"
}

