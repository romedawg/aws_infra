/// Certificate creation
//resource "aws_s3_bucket" "cert_bucket" {
//  bucket = "certs19292912"
//  acl    = "private"
//
//  tags = {
//    Name        = "certs"
//  }
//}
//
//module "acme-account-registration" {
//
//  source             = "../modules/lets_encrypt_certs/acme-account-registration"
//  registration_email = "roman32@gmail.com"
//  server_url         = "https://acme-v02.api.letsencrypt.org/directory"
////  server_url         = "https://acme-v02.api.letsencrypt.org/directory"
//
//}
//
//module "acme-cert-request" {
//  source          = "../modules/lets_encrypt_certs/acme-cert-request"
//  account_key_pem = module.acme-account-registration.account_key_pem
//  server_url         = "https://acme-v02.api.letsencrypt.org/directory"
//}


// POSTGRES RDS TESTING
//module "subnets" {
//  source = "../modules/networking/subnets"
//  vpc_id = module.vpc_old_do_not_use.vpc_id
//}

//module "security_groups" {
//  source      = "../modules/networking/acl"
//  environment = local.environment
//  vpc_old_do_not_use         = module.vpc_old_do_not_use.vpc_id
//}
//
//module "rds_postgres" {
//  source                  = "../modules/rds/postgres"
//  database_name           = "postgres"
//  environment             = local.environment
//  instance_class          = "db.t2.medium"
//  allocated_storage       = "100"
//  engine                  = "postgres"
//  engine_version          = "12.3"
//  pg_family               = "postgres12"
//  port                    = 5432
//  backup_retention_period = 1
//  maintenance_window      = "Sat:03:30-Sat:04:00"
//  backup_window           = "04:30-05:00"
//  //  security_group_id       = module.env.postgres_rds_security_group
//  subnet_group      = [module.subnets.data_one_id, module.subnets.data_two_id]
//  security_group_id = module.security_groups.postgres_rds_security_group
//}

//module "ses_bucket" {
//  source = "../modules/s3"
//
//  bucket_name = "ses-romedawg-com"
//}



