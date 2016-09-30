resource "aws_elastic_beanstalk_application" "django-app-test" {
  name = "django-app-test"
  description = "A very simple django app running in a container."
}

resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name = "development"
  application = "${aws_elastic_beanstalk_application.django-app-test.name}"
  solution_stack_name = "64bit Amazon Linux 2016.03 v2.1.6 running Docker 1.11.2"

  tier = "WebServer"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "${aws_iam_instance_profile.ecr_profile.name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.nano"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "EnvironmentType"
    value = "SingleInstance"
  }
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
