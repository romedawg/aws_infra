// Standalone postgres instances
module "aws_iam_instance_profile" {
  source = "./iam"

  aws_account_id = var.aws_account_id
  aws_region     = var.aws_region
  cluster        = local.cluster

  ssm_agent_policy_arn = var.ssm_agent_policy_arn
}

module "postgres_us_east_2a" {
  source = "./ec2instance"

  cluster-member-identifier = "${var.availability_zone_2a_metadata.zone_id}-1"
  cluster                   = local.cluster
  custom_iops               = var.custom_iops
  custom_throughput         = var.custom_throughput
  data_dir_volume_size      = var.data_dir_volume_size
  iam_instance_profile_name = module.aws_iam_instance_profile.name
  instance_type             = var.instance_type
  key_name                  = var.key_name
  security_group            = var.security_group
  subnet                    = var.availability_zone_2a_metadata.subnet_id
  availability_zone         = var.availability_zone_2a_metadata.zone_id
  encrypt_root_block_device = true
}

resource "aws_route53_record" "postgres_master" {
  name    = "postgres.romedawg.com"
  zone_id = var.private_hosted_zone_id
  type    = "A"
  ttl     = "2"
  records = [module.postgres_us_east_2a.ec2_private_ip]

  # The lifecycle resource ignores any changes/differences between terraform and a resource.
  # Below we are ignoring changes to zone_id and records because the records will maintained
  # by an ansible job. The ansible job will be responsible for updating the DNS record IP in AWS.
  lifecycle {
    ignore_changes = [
      zone_id,
      records,
    ]
  }
}

resource "aws_route53_record" "postgres_read_us_east_2a" {
  name    = "postgresql-read.romedawg.com"
  zone_id = var.private_hosted_zone_id
  type    = "A"
  ttl     = "2"
  records = [module.postgres_us_east_2a.ec2_private_ip]
}

