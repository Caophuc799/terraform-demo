variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "webserver_amis" {
  type = map(string)
}

variable "target_env" {
  default = "dev"
}
