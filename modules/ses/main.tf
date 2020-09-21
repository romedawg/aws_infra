provider "aws" {
  region = "us-east-1"
}

resource "aws_ses_domain_identity" "ses_domain" {
  domain = var.domain
}

resource "aws_route53_record" "example_amazonses_verification_record" {
  zone_id = var.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.ses_domain.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses_domain.verification_token]
}

resource "aws_ses_domain_dkim" "domain" {
  domain = aws_ses_domain_identity.ses_domain.domain
}

resource "aws_route53_record" "amazonses_dkim_record" {
  count   = 3
  zone_id = var.zone_id
  name    = "${element(aws_ses_domain_dkim.domain.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.domain.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

//resource "aws_ses_domain_mail_from" "romedawg" {
//  domain           = aws_ses_domain_identity.ses_domain.domain
//  mail_from_domain = "amazonses.com"
//}

//# Example Route53 MX record
//resource "aws_route53_record" "example_ses_domain_mail_from_mx" {
//  zone_id = var.zone_id
//  name    = aws_ses_domain_mail_from.romedawg.mail_from_domain
//  type    = "MX"
//  ttl     = "600"
//  records = ["10 feedback-smtp.us-east-1.amazonses.com"] # Change to the region in which `aws_ses_domain_identity.example` is created
//}

//# Example Route53 TXT record for SPF
//resource "aws_route53_record" "example_ses_domain_mail_from_txt" {
//  zone_id = var.zone_id
//  name    = aws_ses_domain_mail_from.romedawg.mail_from_domain
//  type    = "TXT"
//  ttl     = "600"
//  records = ["v=spf1 include:amazonses.com -all"]
//}

// Questionable if needed
resource "aws_ses_email_identity" "romedawg" {
  email = "root@${aws_ses_domain_identity.ses_domain.domain}"
}
