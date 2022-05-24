#!/usr/bin/env bash

set -uex
set -o pipefail

CYCLES=0

ACTION="${1}"
EC2_INSTANCE_ID="${2}"
CLUSTER="$3"
AWS_REGION="${4:-us-east-2}"
MAX_CYCLES="${5:-120}"

case "${ACTION}" in
    on)
        DESIRED_STATUS=ACTIVE
        RUNNING_TASK_CONDITION=".runningTasksCount > 0"
        ;;
    off)
        DESIRED_STATUS=DRAINING
        RUNNING_TASK_CONDITION=".runningTasksCount == 0"
        ;;
    *)
        echo "Supported actions are on and off, got ${ACTION}."
        exit 1
        ;;
esac

mapfile -t ALL_CONTAINER_INSTANCES < <(aws ecs list-container-instances --cluster "${CLUSTER}" --region "${AWS_REGION}" \
    | jq -r '.containerInstanceArns[]')

CONTAINER_INSTANCE=$(aws ecs describe-container-instances \
    --cluster "${CLUSTER}" --region "${AWS_REGION}" --container-instances "${ALL_CONTAINER_INSTANCES[@]}" --include TAGS \
    | jq -r '.containerInstances[] | select(.ec2InstanceId == "'"${EC2_INSTANCE_ID}"'") | .containerInstanceArn')

aws ecs update-container-instances-state --cluster "${CLUSTER}" \
    --container-instances "${CONTAINER_INSTANCE}" \
    --status "${DESIRED_STATUS}" --region "${AWS_REGION}"

while [[ "${CYCLES}" -lt "${MAX_CYCLES}" ]]; do

    CONTAINER_INSTANCE_WITH_CONDITIONS_MET=$(aws ecs describe-container-instances \
        --cluster "${CLUSTER}" --region "${AWS_REGION}" --container-instances "${CONTAINER_INSTANCE}" \
        | jq -r '.containerInstances[] | select('"${RUNNING_TASK_CONDITION}"' and .pendingTasksCount == 0 ) | .containerInstanceArn')

    if [[ "${CONTAINER_INSTANCE}" == "${CONTAINER_INSTANCE_WITH_CONDITIONS_MET}" ]]; then
        exit 0
    fi

    CYCLES=$((CYCLES + 1 ))
    sleep 10
done

exit 1
