module "iam" {
  source    = "./modules/iam"
  role_name = var.role_name
  topic_arn = module.sns.topic_arn
}

module "lambda" {
  source          = "./modules/lambda"
  function_name   = var.lambda_function_name
  handler         = var.lambda_handler
  runtime         = var.lambda_runtime
  filename        = var.lambda_filename
  lambda_role_arn = module.iam.role_arn
  dlq_target_arn  = module.sns.topic_arn
  topic_arn       = module.sns.topic_arn
}

module "sns" {
  source            = "./modules/sns"
  topic_name        = var.sns_topic_name
  subscriber_emails = var.subscriber_emails
}

module "eventbridge" {
  source        = "./modules/eventbridge"
  rule_name     = var.rule_name
  schedule_cron = var.schedule_cron
  lambda_arn    = module.lambda.lambda_function_arn
  lambda_name   = var.lambda_function_name
}
