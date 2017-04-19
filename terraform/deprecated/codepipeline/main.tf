# http://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html#pipeline-requirements

resource "aws_codepipeline" "default" {
  name     = "${var.name}"
  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}"

  artifact_store {
    location = "${var.inBucket == "" ? format("codepipeline-%s-%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id) : var.inBucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      category         = "Source"
      name             = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"

      output_artifacts = ["MyApp"]

      # TODO change develop.json to source.zip ???
      configuration {
        S3Bucket    = "${var.outBucket == "" ? format("drone-%s-%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id) : var.outBucket}"
        S3ObjectKey = "${var.name}/develop.json"
      }
    }
  }

  stage {
    name = "Stage"

    action {
      category        = "Deploy"
      name            = "Stage"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      run_order       = "1"
      version         = "1"

      input_artifacts = ["MyApp"]

      configuration {
        ApplicationName = "${var.ApplicationName == "" ? var.name : var.ApplicationName}"
        EnvironmentName = "${var.stageEnv}"
      }
    }

    action {
      category  = "Approval"
      name      = "QAA"
      owner     = "AWS"
      provider  = "Manual"
      run_order = "2"
      version   = "1"

      configuration {
        CustomData         = "${var.qaaComment}"
        ExternalEntityLink = "${var.url}"
        NotificationArn    = "${aws_sns_topic.stage.arn}"
      }
    }

    action {
      category  = "Approval"
      name      = "Product_Owner"
      owner     = "AWS"
      provider  = "Manual"
      run_order = "3"
      version   = "1"

      configuration {
        CustomData         = "${var.ownerComment}"
        ExternalEntityLink = "${var.url}"
        NotificationArn    = "${aws_sns_topic.prod.arn}"
      }
    }
  }

  stage {
    name = "Production"

    action {
      category = "Deploy"
      name      = "Deploy"
      owner     = "AWS"
      provider  = "ElasticBeanstalk"
      run_order = "1"
      version   = "1"

      input_artifacts = ["MyApp"]

      configuration {
        ApplicationName = "${var.ApplicationName == "" ? var.name : var.ApplicationName}"
        EnvironmentName = "${var.prodEnv}"
      }
    }
  }
}
