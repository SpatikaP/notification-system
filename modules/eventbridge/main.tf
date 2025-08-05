resource "aws_cloudwatch_event_rule" "schedule" {
  name                = var.rule_name
  schedule_expression = var.schedule_cron
  is_enabled          = true
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.schedule.name
  arn       = var.lambda_arn
  target_id = "lambda"
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule.arn
}
