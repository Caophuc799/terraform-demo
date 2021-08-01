resource "aws_s3_bucket" "demo-bins" {
  acl = "public-read"
}

output "bucket_url" {
  value = "${aws_s3_bucket.demo-bins.bucket_domain_name}"
}