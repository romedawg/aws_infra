#!/bin/bash

set -ux
set -o pipefail
CLUSTER="$1"
SERVICE="$2"
WANT="$3"
AWS_REGION="${4:-us-east-2}"
MAX_CYCLES="${5:-185}"

FOUND=0

CYCLES=0

while [[ "${CYCLES}" -lt "${MAX_CYCLES}" ]]; do

    IFS=$'\t' read -r -a TASKS <<< "$(aws ecs list-tasks --cluster "${CLUSTER}" --service "${SERVICE}" --query 'taskArns' --region "${AWS_REGION}" --output text)"

    FOUND=$(aws ecs describe-tasks --cluster "${CLUSTER}" --query 'tasks[*].healthStatus' --tasks "${TASKS[@]}" --region "${AWS_REGION}" | grep -c 'HEALTHY')
    echo "Found ${FOUND} / want ${WANT}"
    if [[ "${FOUND}" -eq "${WANT}" ]]; then
        exit 0
    fi

    CYCLES=$((CYCLES + 1 ))
    sleep 1
done

exit 1