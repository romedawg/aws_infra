#!/usr/bin/env bash
#shellcheck disable=SC2016

ecs_cluster_name="${ecs_cluster_name}"
container_uid="${container_uid}"
ecs_service="${ecs_service}"
application_name="${application_name}"
environment="${environment}"
application_cluster="${application_cluster}"
aws_region="${aws_region}"
device_name="${device_name}"

${userdata_content}
