output "deployment_bucket" {
  value = "${aws_s3_bucket.remote_state_bucket.id}"
}
