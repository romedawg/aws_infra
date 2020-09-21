resource "aws_eip" "romedawg_eip" {
  instance = aws_instance.romedawg_ec2.id
  vpc      = true
}

resource "aws_instance" "romedawg_ec2" {
  user_data     = base64encode(file("${path.module}/scripts/userdata.sh"))
  ami        = data.aws_ami.ubuntu_base.id
  monitoring = true
  key_name   = var.key_name

  vpc_security_group_ids = [
    var.security_group,
  ]

  instance_type = "t2.micro"
  subnet_id     = var.subnet

  iam_instance_profile = aws_iam_instance_profile.romedawg_profile.name

  tags = {
    Name          = "romedawg"
    application   = "romedawg"
    environment   = var.environment
    cluster       = "default"
//    "Patch Group" = var.ubuntu_patch_group
  }
}

// Create A record for the site.
resource "aws_route53_record" "romedawg_com_a_record" {
  name = "romedawg.com"
  type = "A"
  zone_id = var.zone_id
  ttl = 300
  records = [aws_eip.romedawg_eip.public_ip]
}
