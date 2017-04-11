resource "aws_elastic_beanstalk_application" "django-app-test" {
  name = "django-app-test"
  description = "A very simple django app running in a container."
}

# https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html
resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name = "devel"
  application = "${aws_elastic_beanstalk_application.django-app-test.name}"
  solution_stack_name = "64bit Amazon Linux 2016.09 v2.5.2 running Multi-container Docker 1.12.6 (Generic)"
#
#  tier = "WebServer"
#
#  setting {
#    namespace = "aws:autoscaling:launchconfiguration"
#    name = "IamInstanceProfile"
#    value = "${aws_iam_instance_profile.ecr_profile.name}"
#  }
#
#  setting {
#    namespace = "aws:autoscaling:launchconfiguration"
#    name = "InstanceType"
#    value = "t2.nano"
#  }
#
#  setting {
#    namespace = "aws:elasticbeanstalk:environment"
#    name = "EnvironmentType"
#    value = "SingleInstance"
#  }
}

resource "aws_iam_instance_profile" "ecr_profile" {
    name = "elastic-beanstalk-web-ecr-profile"
    roles = ["${aws_iam_role.eb-web-ecr-ec2-role.name}"]
}

resource "aws_iam_role" "eb-web-ecr-ec2-role" {
    name = "elastic-beanstalk-web-ecr-ec2-role"
    assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eb-ecr-readonly-attach" {
    role = "${aws_iam_role.eb-web-ecr-ec2-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eb-web-tier-attach" {
    role = "${aws_iam_role.eb-web-ecr-ec2-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "eb-ecs-attach" {
    role = "${aws_iam_role.eb-web-ecr-ec2-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}
