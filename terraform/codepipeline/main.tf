resource "aws_codepipeline" "default" {
  name     = "django-app-test-develop"
  role_arn = "${aws_iam_role.default.arn}"

  artifact_store {
    location = "${aws_s3_bucket.default.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["MyApp"]

      configuration {
        S3Bucket    = "drone-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
        S3ObjectKey = "django-app-test/develop.json"
      }
    }
  }

  stage {
    name = "Stage"

    action {
      name            = "develop"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      run_order       = "1"
      version         = "1"
      category        = "Deploy"
      input_artifacts = ["MyApp"]

      configuration {
        ApplicationName = "django-app-test"
        EnvironmentName = "devel"
      }
    }

    action {
      category = "Approval"
      name     = "QAA"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"

      configuration {
        ExternalEntityLink = "http://develop.camzdqpswk.us-east-2.elasticbeanstalk.com"
      }
    }
  }

  stage {
    name = "Production"

    action {
      name     = "Product_Owner"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"

      configuration {
        ExternalEntityLink = "http://develop.camzdqpswk.us-east-2.elasticbeanstalk.com"
      }
    }

    action {
      category = "Deploy"

      input_artifacts = ["MyApp"]

      name     = "Deploy"
      owner    = "AWS"
      provider = "ElasticBeanstalk"
      version  = "1"

      configuration {
        ApplicationName = "django-app-test"
        EnvironmentName = "production"
      }
    }
  }
}
