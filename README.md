[![Build Status](https://drone.sandbox.aws.illinois.edu/api/badges/techservices/elastic_beanstalk_demo/status.svg)](https://drone.sandbox.aws.illinois.edu/techservices/elastic_beanstalk_demo)

Prerequisites
==========================

1) Terraform

	$ brew install terraform # Mac OSX

2) AWS CLI & AWS Elastic Beanstalk Command Line Tool

	$ brew install aws-elasticbeanstalk # Mac OSX
	$ brew install awscli               # Mac OSX


How to deploy
===============

0) Create Amazon EC2 Container Registry Infrastructure

	$ cd terraform/ecr
	$ terraform plan
	$ terraform apply
	$ cd ../..

1) Create Elastic Beanstalk Infrastructure

	* Add your name of your AWS SSH key to the eb.tf file.

	$ cd terraform/eb
	$ terraform plan
	$ terraform apply
	$ cd ../..

	Note the value of the rds_hostname

2) Add RDS hostname to Dockerfile

	Add the rds_hostname to the Dockerfile as an environment
	variable:

	ENV	   RDS_HOSTNAME		 RDS_HOSTNAME

3) Build & Upload image to ECR

	$ `aws ecr get-login --region us-east-2`  # Login to Amazon ECR
	$ docker build -t django-protoapp .       # Build image
	$ docker tag django-protoapp:latest 378517677616.dkr.ecr.us-east-2.amazonaws.com/django-protoapp:latest
	$ docker push 378517677616.dkr.ecr.us-east-2.amazonaws.com/django-protoapp:latest

4) Initialize Elastic Beanstalk Command Line Tool

	$ cd aws
	$ eb init django-protoapp -r us-east-2

5) Deploy application

	$ eb deploy

6) Create database

	$ eb ssh
        > sudo su
	> docker ps
        > docker exec -it 8d76f5e54cba /bin/bash
        # source venv/bin/activate
	(venv) # python manage.py migrate
	(venv) # python manage.py createsuperuser

Links
==========================

* http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html
