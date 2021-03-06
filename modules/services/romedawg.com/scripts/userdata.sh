#!/usr/bin/env bash

set -o pipefail
set -eu

apt-get update -y

apt-get install nginx -y

function configureNginx() {

  if [[ -f "/etc/nginx/sites-available/default" ]]; then
    rm -rf /etc/nginx/sites-available/*
    rm -rf /etc/nginx/sites-enabled/*
  fi

  mkdir -p /var/www/romedawg.com
  touch /var/www/romedawg.com/index.html

  echo "<html><p>hello</p></html>" > /var/www/romedawg.com/index.html

  if [[ ! -f "/etc/nginx/sites-enabled/romedawg.com" ]];then

    touch /etc/nginx/sites-available/romedawg.com
    ln -s /etc/nginx/sites-available/romedawg.com /etc/nginx/sites-enabled/romedawg.com
  fi

  if [[ ! -f "/etc/nginx/sites-available/romedawg.com" ]]; then
    touch /etc/nginx/sites-available/romedawg.com
  fi
}

configureNginx

request_uri='$request_uri'
server_name='$server_name'
cat << EOF > /etc/nginx/sites-available/romedawg.com
server {
  listen 80;
  server_name romedawg.com www.romedawg.com;
  return 301 https://$server_name$request_uri;
}

server {
  listen 443 ssl;
  server_name romedawg.com www.romedawg.com;

  ssl_certificate /etc/nginx/pki/fullchain.pem;
  ssl_certificate_key /etc/nginx/pki/privkey.pem;


  # TLS 1.3 only
  ssl_protocols TLSv1.2;

  location / {
    alias /var/www/romedawg.com/;
  }
}
EOF

if [[ ! -d /etc/nginx/pki ]]; then
  mkdir /etc/nginx/pki
fi

if [[ ! -f "/etc/nginx/pki/fullchain.pem" ]]; then
  touch /etc/nginx/pki/fullchain.pem
fi

if [[ ! -f "/etc/nginx/pki/privkey.pem" ]]; then
  touch /etc/nginx/pki/privkey.pem
fi

cat << EOF > /etc/nginx/pki/fullchain.pem
-----BEGIN CERTIFICATE-----
MIIFYTCCBEmgAwIBAgISAyPipm1vPYhEdHPpqGN2dN1RMA0GCSqGSIb3DQEBCwUA
MEoxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MSMwIQYDVQQD
ExpMZXQncyBFbmNyeXB0IEF1dGhvcml0eSBYMzAeFw0yMDA5MTcyMDU4MjJaFw0y
MDEyMTYyMDU4MjJaMBcxFTATBgNVBAMTDHJvbWVkYXdnLmNvbTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBANSBiNXCz6f7j7w50UPnBUmx7yN1s5Re76Uc
lE4+rLuH61bZtjFRQj/nNruFSXtd+VOpueZo3UFkr9i94jxfleCsrTDHnfgrne+2
w42+gvtWb02TCAWjFV6kXJ4ufA0UgIZO8HJiWnHavYpuJGYtcoOULEREgu3cFKax
fmhb3WkqPcppYe21e9OpVvOI2S3VaQ6hfnsAJc2Fmw3jwLnv4KyzlPrcL4pb8P3R
A/I4CitDGIH//vdY66NQaiOIMPQzg/uPh28e56liK7d8bugM2i3QKtze2B6wvTZx
OJIux48fiC2DF5xeaN+FPJsxLX2zwLpnRzQx7P2r0pVxcLj0ZbkCAwEAAaOCAnIw
ggJuMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUH
AwIwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQUfPgJ8E3qjWMIXeD+c3zZWV/+HjQw
HwYDVR0jBBgwFoAUqEpqYwR93brm0Tm3pkVl7/Oo7KEwbwYIKwYBBQUHAQEEYzBh
MC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcC5pbnQteDMubGV0c2VuY3J5cHQub3Jn
MC8GCCsGAQUFBzAChiNodHRwOi8vY2VydC5pbnQteDMubGV0c2VuY3J5cHQub3Jn
LzAnBgNVHREEIDAegg4qLnJvbWVkYXdnLmNvbYIMcm9tZWRhd2cuY29tMEwGA1Ud
IARFMEMwCAYGZ4EMAQIBMDcGCysGAQQBgt8TAQEBMCgwJgYIKwYBBQUHAgEWGmh0
dHA6Ly9jcHMubGV0c2VuY3J5cHQub3JnMIIBBQYKKwYBBAHWeQIEAgSB9gSB8wDx
AHYAsh4FzIuizYogTodm+Su5iiUgZ2va+nDnsklTLe+LkF4AAAF0nhNaOAAABAMA
RzBFAiEA9zOu0DHA9Gt4b5LyxkZJsc7clSINj2vXPRjwib+VyPQCICxYY/RT/7M0
ayoMr5i4XcsBp57iutY9CHn59NQn6D8pAHcAb1N2rDHwMRnYmQCkURX/dxUcEdkC
wQApBo2yCJo32RMAAAF0nhNaVQAABAMASDBGAiEAimkQkzw6UTuviFJEczZ3DATb
n8hvHEhQwhjHNc4WaDoCIQCRJJJWG9ZhHVitfLDBxu4GphSFzTJpRpk+GN1T9RAO
ozANBgkqhkiG9w0BAQsFAAOCAQEAg4MJjHDxXdiLQalTA9+JKbLe/cBZlkO/EBec
nZlhXmtMVvz2J8YwczzjJLfy+e1WGyQ/ZYUODciI64ZhtKoDjFZTPfEu2GChmaU6
GTjW+GVx/mG0jIe3yrn6GQf1OIhKk3EEz2PaEs0M702mSGAUbDqGCCpBRKzt2v2V
HMD7W8sFOIlEaAorBiwIuHxVIgRhljhk0yqC7GmR069SRA2Fx/kfaDgCHkmCORnk
k07casAYEXVqjeLHHJhCjxrmrKOOIeUfBN1oHrDI2XEUhtpDx7RBq3+Gc4emxdUA
bcJchZQFwEEvPAb+XcWFLpt3MloOImz4NicQleKyzT811NMqeQ==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIEkjCCA3qgAwIBAgIQCgFBQgAAAVOFc2oLheynCDANBgkqhkiG9w0BAQsFADA/
MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT
DkRTVCBSb290IENBIFgzMB4XDTE2MDMxNzE2NDA0NloXDTIxMDMxNzE2NDA0Nlow
SjELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUxldCdzIEVuY3J5cHQxIzAhBgNVBAMT
GkxldCdzIEVuY3J5cHQgQXV0aG9yaXR5IFgzMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAnNMM8FrlLke3cl03g7NoYzDq1zUmGSXhvb418XCSL7e4S0EF
q6meNQhY7LEqxGiHC6PjdeTm86dicbp5gWAf15Gan/PQeGdxyGkOlZHP/uaZ6WA8
SMx+yk13EiSdRxta67nsHjcAHJyse6cF6s5K671B5TaYucv9bTyWaN8jKkKQDIZ0
Z8h/pZq4UmEUEz9l6YKHy9v6Dlb2honzhT+Xhq+w3Brvaw2VFn3EK6BlspkENnWA
a6xK8xuQSXgvopZPKiAlKQTGdMDQMc2PMTiVFrqoM7hD8bEfwzB/onkxEz0tNvjj
/PIzark5McWvxI0NHWQWM6r6hCm21AvA2H3DkwIDAQABo4IBfTCCAXkwEgYDVR0T
AQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwfwYIKwYBBQUHAQEEczBxMDIG
CCsGAQUFBzABhiZodHRwOi8vaXNyZy50cnVzdGlkLm9jc3AuaWRlbnRydXN0LmNv
bTA7BggrBgEFBQcwAoYvaHR0cDovL2FwcHMuaWRlbnRydXN0LmNvbS9yb290cy9k
c3Ryb290Y2F4My5wN2MwHwYDVR0jBBgwFoAUxKexpHsscfrb4UuQdf/EFWCFiRAw
VAYDVR0gBE0wSzAIBgZngQwBAgEwPwYLKwYBBAGC3xMBAQEwMDAuBggrBgEFBQcC
ARYiaHR0cDovL2Nwcy5yb290LXgxLmxldHNlbmNyeXB0Lm9yZzA8BgNVHR8ENTAz
MDGgL6AthitodHRwOi8vY3JsLmlkZW50cnVzdC5jb20vRFNUUk9PVENBWDNDUkwu
Y3JsMB0GA1UdDgQWBBSoSmpjBH3duubRObemRWXv86jsoTANBgkqhkiG9w0BAQsF
AAOCAQEA3TPXEfNjWDjdGBX7CVW+dla5cEilaUcne8IkCJLxWh9KEik3JHRRHGJo
uM2VcGfl96S8TihRzZvoroed6ti6WqEBmtzw3Wodatg+VyOeph4EYpr/1wXKtx8/
wApIvJSwtmVi4MFU5aMqrSDE6ea73Mj2tcMyo5jMd6jmeWUHK8so/joWUoHOUgwu
X4Po1QYz+3dszkDqMp4fklxBwXRsW10KXzPMTZ+sOPAveyxindmjkW8lGy+QsRlG
PfZ+G6Z6h7mjem0Y+iWlkYcV4PIWL1iwBi8saCbGS5jN2p8M+X+Q7UNKEkROb3N6
KOqkqm57TH2H3eDJAkSnh6/DNFu0Qg==
-----END CERTIFICATE-----
EOF

cat << EOF > /etc/nginx/pki/privkey.pem

EOF


systemctl restart nginx.service

exit 0
