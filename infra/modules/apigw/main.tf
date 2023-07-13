resource "aws_apigatewayv2_api" "main" {
  name          = "slackbot"
  protocol_type = "HTTP"

  # cors_configuration {
  #   allow_origins = ["*"]
  #   allow_methods = ["*"]
  #   allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
  # }
}

# resource "aws_apigatewayv2_integration" "photoserver_lambda" {
#   api_id                 = aws_apigatewayv2_api.main.id
#   integration_type       = "AWS_PROXY"
#   integration_method     = "POST"
#   integration_uri        = var.photoserver_lambda_invoke_arn
#   payload_format_version = "2.0"
# }

# resource "aws_apigatewayv2_route" "all" {
#   api_id    = aws_apigatewayv2_api.main.id
#   route_key = "ANY /"
#   target    = "integrations/${aws_apigatewayv2_integration.photoserver_lambda.id}"
# }

# resource "aws_apigatewayv2_stage" "default" {
#   api_id      = aws_apigatewayv2_api.main.id
#   name        = "$default"
#   auto_deploy = true

#   default_route_settings {
#     throttling_burst_limit = 1
#     throttling_rate_limit  = 1
#   }
# }

# resource "aws_apigatewayv2_deployment" "todos" {
#   api_id      = aws_apigatewayv2_route.all.api_id
#   description = "All"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_lambda_permission" "api_gateway" {
#   statement_id  = "photoserver-${var.env_affix}-MainLambdaPermissionHttpApi"
#   action        = "lambda:InvokeFunction"
#   function_name = var.photoserver_function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*"
# }
