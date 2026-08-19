locals {
  availability_zones = {
    z2a = "${var.aws_region}a"
    z2b = "${var.aws_region}b"
    z2c = "${var.aws_region}c"
  }
}
