resource "aws_sns_topic" "stage" {
  name = "pipeline-${var.name}-stage"
}

resource "aws_sns_topic" "prod" {
  name = "pipeline-${var.name}-production"
}
