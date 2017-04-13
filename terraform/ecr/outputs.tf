output "AWS_ACCESS_KEY_ID" {
  value = "${aws_iam_access_key.default.id}"
}

output "AWS_SECRET_ACCESS_KEY" {
  value = "${aws_iam_access_key.default.secret}"
}
