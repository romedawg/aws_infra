module "node_1_m6i" {
  source                    = "../../../infrastructure/ecs/container_instance_ubuntu"
  node_id                   = "1"
  instance_type             = local.instance_type_m6i
  subnet                    = var.subnets[0]
  environment               = var.environment
  application_name          = var.application_name
  ecs_service               = "${var.application_name}"
  application_cluster       = var.cluster
  ecs_cluster_name          = "rome"
  container_uid             = local.container_uid
  data_volume_size          = local.data_volume_size
  iam_instance_profile_name = var.iam_instance_profile_name
  key_name                  = var.key_name
  security_groups           = [aws_security_group.generic_security_group.id]
  data_volume_type          = local.data_volume_type
  cluster                   = var.cluster
  ami                       = var.ami
}

#module "node_2_m6i" {
#  source                    = "../../../infrastructure/ecs/container_instance_ubuntu"
#  node_id                   = "2"
#  instance_type             = local.instance_type_m6i
#  subnet                    = var.subnets[1]
#  environment               = var.environment
#  application_name          = local.application_name
#  ecs_service               = "${var.environment}-${local.application_name}"
#  application_cluster       = var.cluster
#  ecs_cluster_name          = var.environment
#  container_uid             = local.container_uid
#  data_volume_size          = local.data_volume_size
#  iam_instance_profile_name = var.iam_instance_profile_name
#  key_name                  = var.key_name
#  security_groups           = var.security_groups
#  data_volume_type          = local.data_volume_type
#  cluster                   = var.cluster
#  ami = "ami-0ab0629dba5ae551d"
#}
