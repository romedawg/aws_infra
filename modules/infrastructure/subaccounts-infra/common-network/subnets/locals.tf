locals {
  full_zone   = "${var.aws_region}${var.zone}"
  zone_titled = join("", [for part in split("-", local.full_zone) : title(part)])

  subnet_ids_grouped_by_path = {
    for subnet_key, a_subnet in aws_subnet.subnet :
    "${a_subnet.tags["zone"]}___${a_subnet.tags["prefix"]}" => a_subnet.id
  }
}
