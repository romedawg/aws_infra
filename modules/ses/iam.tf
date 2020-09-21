//data "aws_iam_policy_document" "allow_assume_role" {
//  version = "2012-10-17"
//
//  statement {
//    effect = "Allow"
//
//    actions = [
//      "sts:AssumeRole",
//    ]
//
//    principals {
//      type = "Service"
//
//      identifiers = [
//        "ec2.amazonaws.com",
//      ]
//    }
//  }
//}
//
//resource "aws_iam_role" "ses_assume_role" {
//  name = "ses_assume_role"
//
//  assume_role_policy = data.aws_iam_policy_document.allow_assume_role.json
//}
//
//
//resource "aws_iam_user" "astronomer" {
//  name = "astronomer@romedag.com"
//}
//
//
//resource "aws_iam_policy" "ses_iam_role" {
//  name        = "SESSendPolicy"
//  description = "Provides the ability to send SES Mail"
//  policy      = <<EOF
//{
//  "Statement": [
//    {
//      "Action": [
//        "ses:SendRawEmail"
//      ],
//      "Effect": "Allow",
//      "Resource": "*"
//    }
//  ],
//  "Version": "2012-10-17"
//}
//EOF
//}
//
////resource "aws_iam_role_policy_attachment" "ses-send_mail-attachment" {
////  role = "${aws_iam_role.ec2_iam_role.name}"
////  policy_arn = arn:aws:iam::aws:policy/SESSendMailAccess
////}
//
////resource "aws_iam_role" "romedawg_ses" {
////  name = "romedawg_ses_role"
////
////  assume_role_policy = aws_iam_role.ses_iam_role
////}
