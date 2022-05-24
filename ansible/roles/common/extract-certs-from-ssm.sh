#!/bin/bash

set -ux
set -o pipefail

NGINX_CERT="$1"
NGINX_KEY="$2"
GZIPPED="${3:-}"
NGINX_SSL_PATH="${4:-/etc/nginx/ssl}"
OUTPUT_CERT="${5:-cert.pem}"
OUTPUT_KEY="${6:-key.pem}"

if [[ -n "${GZIPPED}" ]]; then
    # We use gzipped option because current limitation of SSM is 8Kb
    echo "exporting gzipped cert and key to files"
    echo "${NGINX_CERT}" | base64 -d | gunzip - > "${NGINX_SSL_PATH}/${OUTPUT_CERT}"
    echo "${NGINX_KEY}" | base64 -d | gunzip - > "${NGINX_SSL_PATH}/${OUTPUT_KEY}"
else
    echo "exporting cert and key to files"
    echo "${NGINX_CERT}" | base64 -d > "${NGINX_SSL_PATH}/${OUTPUT_CERT}"
    echo "${NGINX_KEY}" | base64 -d > "${NGINX_SSL_PATH}/${OUTPUT_KEY}"
fi
