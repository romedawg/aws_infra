resource "aws_iam_role_policy_attachment" "read_permissions" {
  role       = aws_iam_role.assets_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role" "assets_role" {
  name               = "AssetsReadRole"
  description        = "Cross account role for read only permissions from root account for Atlassian Assets"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}
