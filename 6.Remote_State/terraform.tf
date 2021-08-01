terraform {
  backend "s3" {
    bucket = "demo-state" # bucket name
    key = "demo-state/terraform.tfstate" # path in the bucket of s3 
    region = "us-east-1"
    profile = "default"
  }
}