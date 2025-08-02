resource "aws_lambda_function" "lambda" {
  function_name    = var.function_name
  role             = var.lambda_role_arn
  handler          = var.handler
  runtime          = var.runtime
  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)
  dead_letter_config {
    target_arn = var.dlq_target_arn
  }
  environment {
    variables = {
      SNS_TOPIC_ARN = var.topic_arn
    }
  }
}