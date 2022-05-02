// Creates the network topology
module "base_module" {
  source = "../infrastructure/networking/topology"
}

module "iam_users" {
  source = "../infrastructure/iam/users"
}