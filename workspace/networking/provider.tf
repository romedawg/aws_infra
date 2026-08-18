provider "aws" {
  shared_credentials_file = "/Users/rrafacz/.aws/credentials"
  region                  = "us-east-1"
  version                 = "2.60.0"
}

provider "template" {
}

provider "random" {
}
