resource "aws_iam_user" "rafacz" {
  name = "rafacz"
  path = "/"
}

resource "aws_iam_role" "s3BucketRole" {
  name = "s3BucketRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "s3_romedawg_write" {
  name        = "romedawgS3Write"
  path        = "/"
  description = "s3 policy for writing to an s3 ucket"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::romedawg"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "rafacz_policy_attachment" {
  name       = "rafacz-attachement"
  users      = [aws_iam_user.rafacz.name]
  roles      = [aws_iam_role.s3BucketRole.name]
  policy_arn = aws_iam_policy.s3_romedawg_write.arn
}