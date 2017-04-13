resource "aws_iam_user" "default" {
  name = "django-app-test"
  path = "/ecr/"
  
  force_destroy = true
}

resource "aws_iam_access_key" "default" {
  user = "${aws_iam_user.default.name}"
}

resource "aws_iam_user_policy" "ecr_wo" {
  name = "test"
  user = "${aws_iam_user.default.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ],
      "Effect": "Allow",
      "Resource": "${aws_ecr_repository.default.arn}"
    }
  ]
}
EOF
}
