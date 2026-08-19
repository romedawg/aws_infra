Here is code provided by NewRelic.

newrelic-config
---------------
This is the repo / code, that should be configured in all accounts without
exceptions.
```
# We don't use whole repo here
git clone https://github.com/newrelic/terraform-provider-newrelic.git
cd terraform-provider-newrelic
git checkout 3d250d612700ce76aa17f1e7de5e997933697328
cd ..
mkdir newrelic-config
cp terraform-provider-newrelic/examples/modules/cloud-integrations/aws/*.tf newrelic-config/

# Cleanup old repo
rm -rf terraform-provider-newrelic
```

We also added metric filters to `aws_cloudwatch_metric_stream` to reduce our spend and restricted newrelic pull region to us-east-2.

aws-log-ingestion
-----------------
This repo creates lambda to ingest cloudwatch logs to New Relic.
```
git clone https://github.com/newrelic/aws-log-ingestion.git
cd aws-log-ingestion
git checkout afa94b054d808d45aaaa0be69cdfc04a568fa39a
rm -rf .git .github
```
Besides that, we added hadolint ignore pragma to Dockerfile to be able to merge the PR. Also file src/requirements.txt was removed from .gitignore.
