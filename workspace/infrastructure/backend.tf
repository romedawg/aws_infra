terraform {
  backend "s3" {
    bucket         = "terraform-romedawg"
    key            = "aws-infra/terraform.tfstate"
    region         = "us-east-2"
//    dynamodb_table = "terraform-TableLock1"
//    encrypt        = true
  }
}
