#!/bin/bash

set -uxe
set -o pipefail

HOSTED_ZONE_NAME="$1"
DNS_RECORD_NAME="$2"

HOSTED_ZONE_ID=$(aws route53 list-hosted-zones \
    | jq -r ".HostedZones[] | select(.Name == \"${HOSTED_ZONE_NAME}\") | .Id" \
    | sed -e "s/\/hostedzone\///")

DNS_RECORD_DETAILS=$(aws route53 list-resource-record-sets \
    --hosted-zone-id "${HOSTED_ZONE_ID}" \
    --query "ResourceRecordSets[?Name == '${DNS_RECORD_NAME}']" \
    | jq -r .[])

if [[ -z "${DNS_RECORD_DETAILS}" ]]; then
  echo "No record set with name ${DNS_RECORD_NAME} found in hosted zone ${HOSTED_ZONE_NAME}."
  exit 1
fi

DNS_TYPE=$(echo "${DNS_RECORD_DETAILS}" | jq -r .Type)
DNS_TTL=$(echo "${DNS_RECORD_DETAILS}" | jq -r .TTL)

echo "${HOSTED_ZONE_ID}"
echo "${DNS_TYPE}"
echo "${DNS_TTL}"
