# Create IAM role that can be used in Backup plans
data "aws_iam_policy_document" "backup_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "backup_role" {
  name               = "GoHealthAWSBackup"
  assume_role_policy = data.aws_iam_policy_document.backup_assume_role.json
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

# Create IAM role that can be used in Restore plans for the Backup service
data "aws_iam_policy_document" "backup_restore_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "restore_role" {
  name               = "GoHealthAWSBackupRestore"
  assume_role_policy = data.aws_iam_policy_document.backup_restore_assume_role.json
}

resource "aws_iam_role_policy_attachment" "restore_policy" {
  role       = aws_iam_role.restore_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}
