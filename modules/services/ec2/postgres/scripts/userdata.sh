#!/usr/bin/env bash

set -eux
set -o pipefail

INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
AWS_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
ENVIRONMENT=$(aws ec2 describe-tags --region "${AWS_REGION}" --filters "Name=resource-id,Values=${INSTANCE_ID}" "Name=key,Values=environment" | jq -r '.Tags[].Value')

POSTGRES_DATA_DIR=/var/lib/postgres

set_volume_ids(){

  ebs_json_file="$(mktemp)"
  touch "${ebs_json_file}"
  aws ec2 describe-volumes --region "${AWS_REGION}" --filters "Name=attachment.instance-id,Values=${INSTANCE_ID}" > "${ebs_json_file}" || exit 1

  vol_array_length=$(jq '.Volumes | length' "${ebs_json_file}")

  volume_counter=0
  while [ "${volume_counter}" -lt "${vol_array_length}" ];do
    tags_array_length=$(jq '.Volumes['"${volume_counter}"'].Tags | length' "${ebs_json_file}" )
    tag_counter=0
      while [ "${tag_counter}" -lt "${tags_array_length}" ];do
        tag_value=$( jq -r .Volumes["${volume_counter}"].Tags["${tag_counter}"].Value "${ebs_json_file}")
        volume_id=$( jq -r .Volumes["${volume_counter}"].VolumeId "${ebs_json_file}")

        # Change volume id to remove hyphen(not part of the serial in lsblk)
        case "${tag_value}" in
          postgres-data-dir)
            echo "postgres-data id is ${volume_id}"
            POSTGRES_DATA_VOL_ID=$(echo "${volume_id}" | tr -d '-')
            ;;
        esac

        tag_counter=$(( tag_counter + 1 ))
      done
  volume_counter=$(( volume_counter + 1 ))
  done

  rm "${ebs_json_file}"
  return 0
}

format_disk(){
    if [ "$#" -ne 2 ]; then
        echo "format_disk takes two parameters"
        return 1
    fi

    local volume_id="$1"
    local mnt="$2"
#shellcheck disable=SC2155
    local disks="$(lsblk -b -o NAME,SIZE,MODEL,SERIAL | grep "Amazon" |  grep "${volume_id}" | awk '{print $1}')"
    local temporary_backup="${mnt}_backup"

    for disk in $disks; do
        local partition="/dev/$disk"
        if grep "$partition" /etc/fstab &>/dev/null; then
            # Partition is not usable - at least not as a new partition.
            continue
        fi
        # We have some partition here, that is not in fstab. It may contain some data or be unformatted.
        # Be careful not to delete some important data.
        if ! blkid "$partition" &>/dev/null; then
            # This partition is not yet formatted.
            mkfs.xfs "${partition}"

            if [ -d "${mnt}" ]; then
                # Mysql typically saves something important to these directories.
                # We need that and should not mount over it. Solution:
                # 1. Move the data away to temporary backup.
                # 2. Make a new filesystem.
                # 3. Move data back to new filesystem.
                # Mounting over this data would create confusion.
                mv "${mnt}" "${temporary_backup}"
            fi
        fi
        mkdir -p "${mnt}"
        chmod 1770 "${mnt}"
#shellcheck disable=SC2155
        local disk_id="$(blkid -c /dev/null -o value -s UUID "${partition}")"
        if [ -z "${disk_id}" ]; then
          echo "Disk was not found"
          exit 1
        fi
        echo "UUID=${disk_id}  ${mnt} xfs defaults 1   1 # At format time, it was ${partition}" >> /etc/fstab
        mount "${mnt}"
        chmod 1770 "${mnt}"
        if [ -d "${temporary_backup}" ]; then
            # Try to match everything if found. We could skip this, but there is set -e, so list it first.
            # Normal files.
            if ls "${temporary_backup}"/* >/dev/null 2>&1; then
                mv "${temporary_backup}"/* "${mnt}"
            fi
            # Hidden files, but not parent directory.
            if ls "${temporary_backup}"/.[^.]* >/dev/null 2>&1; then
                mv "${temporary_backup}"/.[^.]* "${mnt}"
            fi

            rmdir "${temporary_backup}"
        fi
        return 0
    done

    echo "Usable disk with volume id $volume_id not found! Unusable disks: $disks"
    return 1
}

get_tag_from_instance(){
    local tag="$1"
    aws ec2 describe-tags --region "${AWS_REGION}" --filters "Name=resource-id,Values=${INSTANCE_ID}" "Name=key,Values=${tag}" | jq -r '.Tags[].Value'
}

set_volume_ids

# Disk sizes are represented in Bytes
format_disk "${MYSQL_DATA_VOL_ID}" "${POSTGRES_DATA_DIR}"
