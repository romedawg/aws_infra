resource "aws_ssm_parameter" "ad_awsread_dn" {
  count = var.adawsread_dn == "" ? 0 : 1

  name  = "/all/ad/adawsread/dn"
  value = var.adawsread_dn
  type  = "String"
}

resource "aws_ssm_parameter" "ad_awsread_password" {
  count = var.adawsread_password == "" ? 0 : 1

  name  = "/all/ad/adawsread/password"
  value = var.adawsread_password
  type  = "SecureString"
}
