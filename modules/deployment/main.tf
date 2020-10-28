resource "aws_s3_bucket" "remote_state_bucket" {
  bucket = format("%s-state", var.prefix)
  acl    = "private"
}
