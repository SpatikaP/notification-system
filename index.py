import json
import boto3
import urllib.request
import urllib.error
import datetime
import os

sns = boto3.client('sns')
topic_arn = os.environ['SNS_TOPIC_ARN']

def handler(event, context):
    try:
        response = urllib.request.urlopen("https://official-joke-api.appspot.com/random_joke")
        return {"message": "Success!"}
    except urllib.error.URLError as e:
        error_message = {
            "timestamp": str(datetime.datetime.now()),
            "error": str(e),
            "function": "ingestion-notifier",
            "severity": "HIGH"
        }

        sns.publish(
            TopicArn=topic_arn,
            Subject="🚨 Lambda Ingestion Failed",
            Message=json.dumps(error_message, indent=2)
        )
        raise Exception("External API call failed")