locals {
  long_name = "${var.environment}-svc-${var.vcs_repository_name}"

  // IAM role name cannot be greater than 64 characters and we don't control what the consumer will inject in and
  // they are in fact injecting in names greater than 64 characters. so we will truncate the name after 64th character.
  short_name = replace(local.long_name, "/(.{0,64})(.*)/", "$1")

  long_name_migration  = "${local.long_name}-migration"
  short_name_migration = replace(local.long_name_migration, "/(.{0,64})(.*)/", "$1")
}

