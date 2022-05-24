#!/usr/bin/env python3

import argparse
import time

import boto3
import json

ap = argparse.ArgumentParser()
ap.add_argument("--log_group", required=True, help="Log group")
ap.add_argument("--log_stream_prefix", required=True, help="Log stream prefix")
ap.add_argument("--aws_region", required=True, help="AWS Region")
ap.add_argument("--save_logs", action='store_true', required=False,
                help="Save logs to SRE bucket")
ap.add_argument("--target_bucket", required=False,
                help="Target bucket to store logs")
ap.add_argument("--target_prefix", required=False, default="logs")
args = vars(ap.parse_args())
log_group = args['log_group']
aws_region = args['aws_region']
log_stream_prefix = args['log_stream_prefix']
save_logs = args['save_logs']
target_bucket = args['target_bucket']
target_prefix = args['target_prefix']


def wait_for_logs():
    cloudwatch_client = boto3.client('logs', region_name=aws_region)
    end_time = time.time() + 60
    while time.time() < end_time:
        response = cloudwatch_client.filter_log_events(
            logGroupName=log_group,
            logStreamNamePrefix=log_stream_prefix
        )
        if len(response['events']) > 0:
            return response['events']
        print("sleeping for 10 seconds")
        time.sleep(10)
    return None


def save_logs_to_s3(logs, target_bucket, prefix):
    with open('logs.txt', 'w') as fp:
        json.dump(logs, fp)
    s3_client = boto3.client('s3', region_name=aws_region)
    log_filename = "{}{}/{}.txt".format(target_prefix,
                                        log_group,
                                        log_stream_prefix)
    s3_client.upload_file('logs.txt', target_bucket, log_filename)


logs = wait_for_logs()
if save_logs:
    save_logs_to_s3(logs, target_bucket, target_prefix)

assert len(logs) > 0, "No events have been logged to Cloudwatch " \
                      "within specified amount of time"
print("{} events have been logged to Cloudwatch".format(len(logs)))
