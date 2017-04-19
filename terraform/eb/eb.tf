# https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html

resource "aws_elastic_beanstalk_application" "default" {
  name = "${var.name}"
  description = "${var.description}"
}

resource "aws_elastic_beanstalk_environment" "stage" {
  name = "stage"
  application = "${aws_elastic_beanstalk_application.default.name}"
  template_name = "${aws_elastic_beanstalk_configuration_template.default.name}"

  tags = "${merge(map("Environment", "stage"), var.tags)}"
}

resource "aws_elastic_beanstalk_environment" "prod" {
  name = "production"
  application = "${aws_elastic_beanstalk_application.default.name}"
  template_name = "${aws_elastic_beanstalk_configuration_template.default.name}"

  tags = "${merge(map("Environment", "production"), var.tags)}"
}

resource "aws_elastic_beanstalk_configuration_template" "default" {
  name = "default"
  application = "${aws_elastic_beanstalk_application.default.name}"
  solution_stack_name = "64bit Amazon Linux 2016.09 v2.5.2 running Multi-container Docker 1.12.6 (Generic)"

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
