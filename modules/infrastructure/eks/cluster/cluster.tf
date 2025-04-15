data "aws_iam_policy_document" "cluster" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "eks.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "eks" {
  name               = "EKSServiceRole-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.cluster.json
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_eks_cluster" "cluster" {
  name     = var.environment
  version  = var.kubernetes_version
  role_arn = aws_iam_role.eks.arn

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]

  vpc_config {
    security_group_ids = [
      var.cluster_security_group,
    ]

    subnet_ids = var.subnets

    endpoint_private_access = true
    endpoint_public_access  = false
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_service_policy,
  ]

}

data "tls_certificate" "cluster_issuer" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cluster_issuer.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

# resource "aws_eks_addon" "kube_proxy" {
#   cluster_name      = var.environment
#   addon_name        = "kube-proxy"
#   addon_version     = "v1.24.15-eksbuild.2"
#   tags = {
#     eks_addon = "kube-proxy"
#   }
# }
