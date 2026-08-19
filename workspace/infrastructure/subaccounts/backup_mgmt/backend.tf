# terraform {
#   backend "s3" {
#     bucket = "terraform-romedawg"
#     role_arn = "arn:aws:iam::701164309191:role/BackupMgmtRole"
#     key    = "aws-backup-mgmt/terraform.tfstate"
#     region = "us-east-2"
#     //    dynamodb_table = "terraform-TableLock1"
#     //    encrypt        = true
#   }
# }
