data "aws_ami" "ecs_optimized_amazon_linux_2" {
  name_regex = "^${local.ami_name}$"
  owners     = [local.ami_owner]
}

resource "aws_instance" "container_instance" {
  ami                  = data.aws_ami.ecs_optimized_amazon_linux_2.id
  monitoring           = true
  key_name             = var.key_name
  iam_instance_profile = var.iam_instance_profile_name

  vpc_security_group_ids = [
    var.security_group,
  ]

  instance_type = var.instance_type
  subnet_id     = var.subnet
  user_data     = base64encode(file("${path.module}/scripts/userdata.sh"))

  lifecycle {
    prevent_destroy = true
  }

  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_size           = var.data_volume_size
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = false
  }

  tags = {
    application      = var.application
    ecs-cluster      = var.environment
    Name             = "${var.environment}-container_instance"
    data-volume-size = "${var.data_volume_size}G"
    "Patch Group"    = var.amazonlinux_patch_group
  }

  volume_tags = {
    environment = var.environment
  }
}

