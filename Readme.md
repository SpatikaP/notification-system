# 📣 AWS Lambda + SNS Notification System (Terraform)

This project sets up a notification system using:

- **AWS Lambda** – Executes logic that either succeeds or fails
- **Amazon SNS** – Sends email notifications on success or failure
- **Terraform** – Infrastructure as Code
- **IAM Roles** – With least-privilege access policies

---

## Architecture Overview

```
 +------------+        +-------------------------------+        +-------------------------+
 |            |        |                               |        |                         |
 |  Trigger   +------->+  AWS Lambda (data-ingestion)  +------->+  SNS Topic: 'notifier'  |
 |            |        |                               |        |                         |
 +------------+        +-------------------------------+        +-------------------------+

```

---

## Project Structure

```

.
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── modules
│   ├── lambda
│   │   └── main.tf
│   │   └── variables.tf
│   │   └── output.tf
│   ├── sns
│   │   └── main.tf
│   │   └── variables.tf
│   │   └── output.tf
│   └── iam
│   │   ├── main.tf
│   │   └── variable.tf
│   │   └── output.tf
└── lambda_function.zip
└── notifier.py   # Your Lambda function

````

---

## Features

- **Lambda Execution**: Simulates a success or failure scenario
- **SNS Email Subscription**: Sends email alerts when the Lambda executes
- **IAM Role**: Grants `sns:Publish` only to the specific SNS topic
- **Modular Design**: Uses reusable Terraform modules for Lambda, IAM, and SNS

---

## Prerequisites

- Terraform v1.0+
- AWS CLI with configured credentials
- Email address to subscribe to SNS

---

## Setup Instructions

### 1. Clone the Repo

```bash
git clone https://github.com/your-org/lambda-sns-terraform.git
cd notification-system
````

### 2. Fill in Variables

Edit `terraform.tfvars`:

```hcl
region               = "ap-south-1"
subscriber_emails    = ["your.email@example.com"]
role_name            = "notifier-lambda-role"
lambda_filename      = "lambda_function.zip"
lambda_function_name = "ingestion-notifier"
lambda_handler       = "notifier.handler"
lambda_runtime       = "python3.9"
sns_topic_name       = "notifier-topic"
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan and Apply

```bash
terraform plan
terraform apply
```

 An email will be sent to the address you provided. **Confirm the subscription** via email.

---

## Test the Setup

You can invoke the Lambda manually to simulate success/failure:

```bash
aws lambda invoke \
  --function-name ingestion-notifier \
  --payload '{}' \
  output.json
```

You should receive an email if the Lambda function fails or succeeds (based on your logic).

---

## Cleanup

```bash
terraform destroy
```

This will remove all AWS resources provisioned by this project.

---

## Notes

* Ensure your IAM role for Lambda includes `sns:Publish` permissions to the specific SNS topic.
* The email subscription needs to be confirmed before you start receiving messages.
* You can customize the Lambda function to trigger from an API Gateway, EventBridge rule, or CloudWatch event.

---

## Contributors

* Spatika – DevOps Engineer

---