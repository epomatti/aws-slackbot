locals {
  filename = "${path.module}/init.zip"
}

resource "aws_lambda_function" "slackbot" {
  function_name    = var.name
  role             = var.execution_role_arn
  filename         = local.filename
  source_code_hash = filebase64sha256(local.filename)
  runtime          = "go1.x"
  handler          = "main"

  memory_size = 128
  timeout     = 10

  environment {
    variables = {
      TEST = ""
    }
  }

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash
    ]
  }
}
