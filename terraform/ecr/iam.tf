#resource "aws_iam_user" "default" {
#  name = "django-app-test"
#  path = "/ecr/"
#  
#  force_destroy = true
#}
#
#resource "aws_iam_access_key" "default" {
#  user = "${aws_iam_user.default.name}"
#}
#
#resource "aws_iam_user_policy" "ecr_wo" {
#  name = "ecrWriteOnly"
#  user = "${aws_iam_user.default.name}"
#
#  policy = "${data.aws_iam_policy_document.ecr_wo.json}"
#}
#
#data "aws_iam_policy_document" "ecr_wo" {
#  statement {
#    actions = [
#      "ecr:GetDownloadUrlForLayer",
#      "ecr:PutImage",
#      "ecr:InitiateLayerUpload",
#      "ecr:UploadLayerPart",
#      "ecr:CompleteLayerUpload",
#    ]
#
#    resources = [
#      "${aws_ecr_repository.default.arn}"
#    ]
#  }
#
#  statement {
#    actions = [
#      "ecr:GetAuthorizationToken",
#    ]
#
#    resources = [ "*" ]
#  }
#}
