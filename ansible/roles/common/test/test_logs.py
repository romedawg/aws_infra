#!/usr/bin/env python3

import argparse
import time

import boto3

ap = argparse.ArgumentParser()
ap.add_argument("--log_group", required=True, help="Log group")
ap.add_argument("--log_stream", required=True, help="Log stream")
ap.add_argument("--aws_region", required=True, help="AWS Region")
args = vars(ap.parse_args())
log_group = args['log_group']
aws_region = args['aws_region']
log_stream = args['log_stream']


def wait_for_logs():
    cloudwatch_client = boto3.client('logs', region_name=aws_region)
    end_time = time.time() + 60
    while time.time() < end_time:
        response = cloudwatch_client.get_log_events(
            logGroupName=log_group,
            logStreamName=log_stream
        )
        if len(response['events']) > 0:
            return response['events']
        print("sleeping for 10 seconds")
        time.sleep(10)
    return None


logs = wait_for_logs()

assert len(logs) > 0, "No events have been logged to Cloudwatch " \
                      "within specified amount of time"
print("{} events have been logged to Cloudwatch".format(len(logs)))
