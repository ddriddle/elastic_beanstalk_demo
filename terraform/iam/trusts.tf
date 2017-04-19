# Reusable trust relationship policy documents

# http://docs.aws.amazon.com/codepipeline/latest/userguide/iam-identity-based-access-control.html
data "aws_iam_policy_document" "codepipeline-trust" {
  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

# http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts-roles.html#concepts-roles-service
data "aws_iam_policy_document" "eb-trust" {
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

# http://docs.aws.amazon.com/codedeploy/latest/userguide/getting-started-create-iam-instance-profile.html
data "aws_iam_policy_document" "ec2-trust" {
  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
