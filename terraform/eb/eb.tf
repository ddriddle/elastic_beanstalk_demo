resource "aws_elastic_beanstalk_application" "django-protoapp" {
  name = "django-protoapp"
  description = "A very simple django app running in a container."
}

resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name = "development"
  application = "${aws_elastic_beanstalk_application.django-protoapp.name}"
  solution_stack_name = "64bit Amazon Linux 2016.03 v2.1.8 running Multi-container Docker 1.11.2 (Generic)"
  tier = "WebServer"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "${aws_iam_instance_profile.ecr_profile.name}"
  }

  setting {
     namespace = "aws:autoscaling:launchconfiguration"
     name = "EC2KeyName"
     value = "roma-fun-mac"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = "${aws_security_group.ec2-rds-sg.name}, ${aws_security_group.ec2-cache-sg.name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.nano"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name = "MeasureName"
    value = "CPUUtilization"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "Statistic"
    value = "Average"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "Unit"
    value = "Percent"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "Period"
    value = "5"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "BreachDuration"
    value = "5"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "UpperThreshold"
    value = "60"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "UpperBreachScaleIncrement"
    value = "20%"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "LowerThreshold"
    value = "20"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "LowerBreachScaleIncrement"
    value = "-20%"
  }
#####

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "EnvironmentType"
    value = "LoadBalanced"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "aws-elasticbeanstalk-service-role"
  }
  tags {
    Name = "roma-protoapp"
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

resource "aws_iam_role_policy_attachment" "eb-ecs-attach" {
  role = "${aws_iam_role.eb-web-ecr-ec2-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}
