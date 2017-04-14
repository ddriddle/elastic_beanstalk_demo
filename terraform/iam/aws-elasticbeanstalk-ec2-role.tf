# http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts-roles.html#concepts-roles-instance

resource "aws_iam_instance_profile" "eb" {
    name = "aws-elasticbeanstalk-ec2-role"
    roles = ["${aws_iam_role.eb.name}"]
}

resource "aws_iam_role" "eb" {
    name = "aws-elasticbeanstalk-ec2-role"
    assume_role_policy = "${data.aws_iam_policy_document.ec2.json}"
}

data "aws_iam_policy_document" "ec2" {
  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eb-ecr-readonly-attach" {
    role = "${aws_iam_role.eb.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eb-web-tier-attach" {
    role = "${aws_iam_role.eb.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "eb-ecs-attach" {
    role = "${aws_iam_role.eb.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_role_policy_attachment" "eb-worker-tier-attach" {
    role = "${aws_iam_role.eb.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}
