#!/usr/bin/env bash

set -uex
set -o pipefail

[[ ! -f /var/log/user-data.log ]] && touch /var/log/user-data.log
chmod 600 /var/log/user-data.log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

function download_script() {
  local local_dir=$1
  local name=$2
  local full_path=
  full_path="${local_dir}/${name}"
  if ! aws s3 cp "s3://romedawg/sre/ec2-userdata-tools/${name}" "${full_path}" ; then
      echo "Failed to download script ${name} from S3"
      return 1
  fi
  chmod u+x "${full_path}"
}

yum update -y
yum install -y awscli jq

SCRIPT_DIR="$(mktemp -d)"

# Format disk
download_script "${SCRIPT_DIR}" format_disk.sh
"${SCRIPT_DIR}/format_disk.sh" data-volume-size /mnt/disk1 ext4
chmod -R 1777 /mnt/disk1
mkdir -p /mnt/disk1/logrouter
chown -R 7091 /mnt/disk1/logrouter

# Get environment
download_script "${SCRIPT_DIR}" get_tag.sh
ENVIRONMENT="$("${SCRIPT_DIR}/get_tag.sh" environment)"

# Set any ECS agent configuration options
echo "ECS_CLUSTER=${ENVIRONMENT}" >> /etc/ecs/ecs.config
echo 'ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs","json-file"]' >> /etc/ecs/ecs.config

APPLICATION="$("${SCRIPT_DIR}/get_tag.sh" application)"
if [ -n "$APPLICATION" ]; then
  GROUP='"application": "'"${APPLICATION}"'",'
fi
# This should be a valid JSON, group adds its comma.
ECS_INSTANCE_ATTRIBUTES='{'"${GROUP}"' "environment": "'"${ENVIRONMENT}"'"}'
echo "ECS_INSTANCE_ATTRIBUTES=${ECS_INSTANCE_ATTRIBUTES}" >> /etc/ecs/ecs.config

# Remove the downloaded scripts
rm -rf "${SCRIPT_DIR}"
