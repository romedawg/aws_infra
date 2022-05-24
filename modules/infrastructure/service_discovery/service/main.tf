resource "aws_service_discovery_service" "service" {
  name = var.service_name

  dns_config {
    namespace_id = var.service_discovery_namespace

    dns_records {
      ttl  = 2
      type = "A"
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

# To share a service discovery namespace with an existing hosted zone (as we desire to do, for simplicity), we need
# to create a record in the existing hosted zone that points to the service discovery hosted zone.  See here for
# more information: https://docs.aws.amazon.com/Route53/latest/APIReference/overview-service-discovery.html.

resource "aws_route53_record" "existing_hosted_zone_record" {
  name    = "${var.service_name}.svc.${var.private_hosted_zone_domain_name}"
  zone_id = var.private_hosted_zone_id
  type    = "A"

  alias {
    zone_id                = var.service_discovery_hosted_zone_id
    name                   = "${aws_service_discovery_service.service.name}.${var.service_discovery_hosted_zone_domain_name}"
    evaluate_target_health = true
  }
}

