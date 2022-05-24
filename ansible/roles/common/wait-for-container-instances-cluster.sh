#!/usr/bin/env bash

set -ux
set -o pipefail
CLUSTER="$1"
WANT="$2"
AWS_REGION="${3:-us-east-2}"
MAX_CYCLES="${4:-60}"

FOUND=0

CYCLES=0

while [[ "${CYCLES}" -lt "${MAX_CYCLES}" ]]; do
    tmpfile=/tmp/bb.txt
    aws ecs list-container-instances --cluster dev --region "${AWS_REGION}" --status ACTIVE | jq '.|{containerInstances:.containerInstanceArns}' > "$tmpfile"
    CONTAINER_INSTANCES_WITH_CLUSTER=$(aws ecs describe-container-instances --cluster dev --region "${AWS_REGION}" --include TAGS --cli-input-json "file://$tmpfile" \
         | jq -r '.containerInstances[] | select(.tags[] | select(.key == "cluster") | .value == "'"${CLUSTER}"'") | .containerInstanceArn')
    rm "$tmpfile"

    FOUND="$(echo "${CONTAINER_INSTANCES_WITH_CLUSTER}" | wc -l)"
    echo "Found ${FOUND} / want ${WANT}"
    if [[ "${FOUND}" -eq "${WANT}" ]]; then
        exit 0
    fi

    CYCLES=$((CYCLES + 1 ))
    sleep 1
done

exit 1
