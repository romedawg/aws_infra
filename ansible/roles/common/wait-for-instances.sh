#!/bin/bash

set -ux
set -o pipefail
ROOT_DIR="$1"
TEST_ID="$2"
ENVIRONMENT="$3"
TAG_APPLICATION_VALUES="$4"
WANT="$5"
SSH_LOGIN="${6:-ubuntu}"
HAVE=0

CYCLES=0
MAX_CYCLES=60

if [[ "$ENVIRONMENT" == "dev" ]]; then
  SSH_CONFIG="ssh_config_test"
else
  SSH_CONFIG="ssh_config"
fi

while [ "$CYCLES" -lt "$MAX_CYCLES" ]; do
    INSTANCES="$(aws ec2 describe-instances --region us-east-2 --query 'Reservations[*].Instances[*].[PrivateIpAddress]' \
             --filters "Name=instance-state-name,Values=running" "Name=tag:environment,Values=${ENVIRONMENT}" "Name=tag:cluster,Values=${TEST_ID}" "Name=tag:application,Values=${TAG_APPLICATION_VALUES}" \
             --output text 2>/tmp/rundbg1err)"
    # shellcheck disable=SC2181
    if [ "$?" -ne 0 ]; then
        echo "We got instances $INSTANCES"
        echo "Failed to get all the instances" >&2
        cat /tmp/rundbg1err >&2
        exit 1
    fi
    FOUND="$(echo "$INSTANCES" | wc -l)"
    HAVE="$(echo "$INSTANCES" | xargs -I{} ssh -l "$SSH_LOGIN" -F "$ROOT_DIR/ansible-build/$SSH_CONFIG" {} hostname 2>/tmp/rundbg2err | tee /tmp/rundbg2out | wc -l )"
    echo "Have $HAVE (found $FOUND) / want $WANT"
    if [ "${HAVE}" -eq "${WANT}" ]; then
        exit 0
    fi
    CYCLES=$((CYCLES + 1 ))
    sleep 1
done

echo "Maximum cycle count has been reached"
exit 1
