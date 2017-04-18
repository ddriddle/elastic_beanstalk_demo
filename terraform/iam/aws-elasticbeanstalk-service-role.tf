# http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts-roles.html#concepts-roles-service

resource "aws_iam_role" "eb-service" {
  name = "aws-elasticbeanstalk-service-role"
  assume_role_policy = "${data.aws_iam_policy_document.eb-service.json}"
}

data "aws_iam_policy_document" "eb-service" {
  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = ["elasticbeanstalk.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["elasticbeanstalk"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eb-service-ehealth-attach" {
    role = "${aws_iam_role.eb-service.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

resource "aws_iam_role_policy_attachment" "eb-service-attach" {
    role = "${aws_iam_role.eb-service.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
}