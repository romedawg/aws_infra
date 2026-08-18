locals {
  aws_account_id    = 983883744684
  aws_region        = "us-east-2"
  environment       = "dev"
  ssh_key_name      = "roman_aws"
  aws_orgization_id = "o-z7ap479ljb"

  mysql = {
    mysql_qa_aws_account = ""
  }

  couchbase = {
    qa_env_aws_account = "024441264067"
  }
}
