data "aws_ami" "ecs_optimized_amazon_linux_2" {
  name_regex = "^${local.ami_name}$"
  owners     = [local.ami_owner]
}

data "aws_subnet" "current" {
  id = var.subnet
}

data "template_file" "user_data_script" {
  template = file("${path.module}/templates/userdata_runner.sh.tpl")

  vars = {
    ecs_cluster_name = var.ecs_cluster_name
    container_uid    = var.container_uid
    ecs_service      = var.ecs_service
    application_name = var.application_name
    userdata_content = file("${path.module}/templates/userdata.sh.part")
  }
}

resource "aws_instance" "container_instance" {
  ami                  = data.aws_ami.ecs_optimized_amazon_linux_2.id
  monitoring           = true
  key_name             = var.key_name
  iam_instance_profile = var.iam_instance_profile_name

  vpc_security_group_ids = var.security_groups

  instance_type = var.instance_type
  subnet_id     = var.subnet
  user_data     = base64encode(data.template_file.user_data_script.rendered)

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      instance_type,
    ]
  }

  # terraform doesn't allow interpolation in tag name within tags block
  tags = merge(
    local.ecs_service_tag,
    {
      "application"      = var.application_name
      "cluster"          = var.application_cluster
      "Name"             = "${var.environment}-container_instance"
      "node_id"          = var.node_id
      "data-volume-size" = "${var.data_volume_size}G"
      "Patch Group"      = var.amazonlinux_patch_group
    },
  )

}

resource "aws_ebs_volume" "ebs" {
  availability_zone = data.aws_subnet.current.availability_zone
  size              = var.data_volume_size
  type              = var.data_volume_type
  encrypted         = false

  iops = var.data_volume_type != "gp2" ? var.data_volume_iops : null

  tags = {
    application = var.application_name
    node_id     = var.node_id
    backup      = "backup_daily_purge_bi_weekly"
  }
}

resource "aws_volume_attachment" "container_instance_ebs_attachment" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = aws_instance.container_instance.id
}

resource "aws_network_interface" "eni" {
  subnet_id       = var.subnet
  security_groups = var.security_groups

  tags = {
    application = var.application_name
    node_id     = var.node_id
  }
}

resource "aws_network_interface_attachment" "container_instance_eni_attachment" {
  instance_id          = aws_instance.container_instance.id
  network_interface_id = aws_network_interface.eni.id
  device_index         = 1
}

