Prerequisites
==========================

1) Terraform

	$ brew install terraform # Mac OSX

2) AWS CLI & AWS Elastic Beanstalk Command Line Tool

	$ brew install aws-elasticbeanstalk # Mac OSX
	$ brew install awscli               # Mac OSX


Howto deploy
===============

1) Create Amazon EC2 Container Registry Infrastructure

	$ cd terraform/ecr
	$ terraform plan
	$ terraform apply
	$ cd ../..

1) Create Elastic Beanstalk Infrastructure

	$ cd terraform/eb
	$ terraform plan
	$ terraform apply
	$ cd ../..

2) Upload image to ECR

	$ `aws ecr get-login --region us-west-2`  # Login to Amazon ECR
	$ docker build -t django-app-test .       # Build image
	$ docker tag django-app-test:latest 378517677616.dkr.ecr.us-west-2.amazonaws.com/django-app-test:latest
	$ docker push 378517677616.dkr.ecr.us-west-2.amazonaws.com/django-app-test:latest

2) Initilize Elastic Beanstalk Command Line Tool
	$ cd aws
	$ eb init django-app-test -r us-west-2 -p "Docker 1.11.2"

3) Deploy application

	$ eb deploy
