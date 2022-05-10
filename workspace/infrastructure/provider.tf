provider "aws" {
  shared_credentials_file = "/Users/rrafacz/.aws/credentials"
  region                  = "us-east-2"
  version                 = "4.9.0"
}

provider "template" {
  version = "2.1.2"
}

provider "random" {
  version = "2.2.1"
}
