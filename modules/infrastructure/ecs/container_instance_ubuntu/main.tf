data "aws_subnet" "current" {
  id = var.subnet
}


data "template_file" "user_data_script" {
  template = file("${path.module}/templates/userdata_runner.sh.tpl")

  vars = {
    ecs_cluster_name                  = var.ecs_cluster_name
    container_uid                     = var.container_uid
    ecs_service                       = var.ecs_service
    application_name                  = var.application_name
    environment                       = var.environment
    application_cluster               = var.application_cluster
    aws_region                        = "us-east-2"
    device_name                       = var.device_name
    userdata_content                  = file("${path.module}/templates/userdata.sh.part")
  }
}

// IETAS-256 AMI: Ubuntu Server 20.04 LTS (HVM), SSD Volume Type focal (64-bit (x86))
resource "aws_instance" "container_instance" {
  ami                  = var.ami
  monitoring           = true
  key_name             = var.key_name
  iam_instance_profile = var.iam_instance_profile_name

  vpc_security_group_ids = var.security_groups

  instance_type = var.instance_type
  subnet_id     = var.subnet
  user_data     = base64encode(data.template_file.user_data_script.rendered)

  # terraform doesn't allow interpolation in tag name within tags block
  tags = merge(
    local.ecs_service_tag,
    {
      "application"        = var.application_name
      "cluster"            = var.application_cluster
      "Name"               = "${var.environment}-container_instance"
      "node_id"            = var.node_id
      "data-volume-size"   = "${var.data_volume_size}G"
      "container_instance" = "true"
      "environment"        = var.environment
    },
  )

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    iops        = var.root_volume_iops

    tags = {
      cluster            = var.application_cluster
      environment        = var.environment
      application        = var.application_name
      container_instance = "true"
    }
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "aws_ebs_volume" "ebs" {
  availability_zone = data.aws_subnet.current.availability_zone
  size              = var.data_volume_size
  type              = var.data_volume_type
  encrypted         = true
  snapshot_id       = var.snapshot_id
  iops              = var.data_volume_type != "gp2" ? var.data_volume_iops : null

  tags = {
    application = var.application_name
    node_id     = var.node_id
    application        = var.application_name
    cluster            = var.application_cluster
    container_instance = "true"
  }
}

resource "aws_volume_attachment" "container_instance_ebs_attachment" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = aws_instance.container_instance.id
}
