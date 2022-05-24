#data "aws_ami" "ubuntu_base" {
#  most_recent = true
#
#  filter {
#    name   = "name"
#    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-20230115"]
#  }
#
#  filter {
#    name   = "virtualization-type"
#    values = ["hvm"]
#  }
#
#  owners = ["ami-08de105e126fec8d8"] # Canonical
#}

resource "aws_instance" "postgres_server" {
  ami               = "ami-0ab0629dba5ae551d"
  monitoring        = true
  key_name          = var.key_name
  user_data         = base64encode(file("${path.module}/scripts/userdata.sh"))
  availability_zone = var.availability_zone

  vpc_security_group_ids = [
    var.security_group,
  ]

  instance_type = var.instance_type
  subnet_id     = var.subnet

  iam_instance_profile = var.iam_instance_profile_name

  root_block_device {
    volume_size = 20
    encrypted   = var.encrypt_root_block_device
  }

  #  lifecycle {
  #    prevent_destroy = true
  #  }

  tags = {
    Name                       = "postgres"
    application                = "postgres"
    cluster                    = var.cluster
    cluster_memeber_identifier = var.cluster-member-identifier
    # Convert the disk size of GiB to Bytes
    data-dir-volume-size = var.data_dir_volume_size * 1024 * 1024 * 1024
  }
}

resource "aws_ebs_volume" "data_dir_volume" {
  availability_zone = var.availability_zone
  size              = var.data_dir_volume_size
  type              = var.disk_type

  // Recommended setting for io1's iops value is volume size * 3.
  // https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ebs-volume-types.html
  // TODO check metrics in cloud watch once prod is running to determine best value
  iops = var.custom_iops != 0 ? var.custom_iops : (var.data_dir_volume_size >= 1000 ? var.data_dir_volume_size * 3 : 3000)

  throughput = var.custom_throughput == 0 ? null : var.custom_throughput

  encrypted = true

  tags = {
    Name                = "postgres-data-dir"
    data-dir-volue-size = var.data_dir_volume_size
  }
}

// device names /dev/sd[f-h]
// https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html
resource "aws_volume_attachment" "data-dir-volume-attachment" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.postgres_server.id
  volume_id   = aws_ebs_volume.data_dir_volume.id
}

