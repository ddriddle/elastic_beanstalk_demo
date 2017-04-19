output "sns_topic_stage" {
  value = "${aws_sns_topic.stage.arn}"
}

output "sns_topic_prod" {
  value = "${aws_sns_topic.prod.arn}"
}
