resource "aws_elastic_beanstalk_application" "django-app-test" {
  name = "django-app-test"
  description = "A very simple django app running in a container."
}

# https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html
resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name = "devel"
  application = "${aws_elastic_beanstalk_application.django-app-test.name}"
  solution_stack_name = "64bit Amazon Linux 2016.09 v2.5.2 running Multi-container Docker 1.12.6 (Generic)"

  tier = "WebServer"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "aws-elasticbeanstalk-service-role"
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

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${data.aws_vpc.selected.id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${data.aws_subnet.public1-a-net.id}"
  }
}
