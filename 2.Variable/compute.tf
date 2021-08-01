resource "aws_instance" "web_server" {
  ami = "${lookup(var.webserver_amis, var.aws_region)}"
  instance_type = "t2.micro" # free tier
}

output "webserver_public_ip" {
  value = "${aws_instance.web_server.public_ip}"
}

resource "aws_instance" "bastion" {
  ami = "${lookup(var.webserver_amis, var.aws_region)}"
  instance_type = "t2.micro"

  count = "${var.target_env == "dev" ? 0 : 2}"
}

output "bastion_ips" {
  value = "${var.target_env == "dev" ? null : aws_instance.bastion.*.private_ip}"
}

output "bastion_ip_0" {
  value = "${var.target_env == "dev" ? null : aws_instance.bastion.*.private_ip[0]}"
}

output "bastion_ip_1" {
  value = "${var.target_env == "dev" ? null : aws_instance.bastion.*.private_ip[1]}"
}

data "template_file" "webserver_policy_template" {
    template = "${file("${path.module}/policy.tpl")}"

    vars = {
        arn = "${aws_instance.web_server.arn}"
    }
}

output "web_server_policy_output" {
    value = "${data.template_file.webserver_policy_template.rendered}"
}