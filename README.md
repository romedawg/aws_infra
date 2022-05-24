# Romans AWS infrastucture
- Networking
    - VPCs, subnets, routing tables, etc..
    - mostly done
- ECS infra
    - Support deploying applications
- IAM users
- s3 Buckets for personal use
- Update letsencrypt cert.
- Add ALB w/ ^ certificae

This is mostly used for testing and deploying Java apps I like to play around with.


## Deploying applications
Ansible was added to create dedicated infrastructure(via terraform) and start ECS-services
 - Postgres/other apps
   - Calls terraform-workspace(creates dedicated ecs ec2instances)
   - Creates ECS service
   - TODO wire in Listener/target groups
     - DNS/Route53 bits - hostname, etc..
