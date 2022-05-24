#!/bin/bash

set -ux
set -o pipefail

INSTANCE_NAME="$1"
APPLICATION="$2"
CLUSTER="$3"
AWS_ENV="$4"

aws ec2 describe-instances --region us-east-2 --query 'Reservations[*].Instances[*].[PrivateIpAddress]' \
	             --filters "Name=instance-state-name,Values=running" "Name=tag:environment,Values=${AWS_ENV}" "Name=tag:Name,Values=${INSTANCE_NAME}" "Name=tag:application,Values=${APPLICATION}" "Name=tag:cluster,Values=${CLUSTER}" \
	             --output text 2>/tmp/rundbg1err
