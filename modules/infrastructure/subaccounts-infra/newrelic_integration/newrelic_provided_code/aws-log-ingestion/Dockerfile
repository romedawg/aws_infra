FROM python:3.11
# hadolint ignore=DL3009
RUN apt-get update
# hadolint ignore=DL3015,DL3059,DL3008
RUN apt-get install -y zip

WORKDIR /build
COPY src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --target .
COPY src .
RUN zip -r /out.zip .

CMD ["/bin/sh"]
