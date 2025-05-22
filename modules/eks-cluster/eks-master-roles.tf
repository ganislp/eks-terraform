data "aws_iam_policy" "eks_cluster_master_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

data "aws_iam_policy" "eks_cluster_vpc_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster_master_role" {
  name               = "eks_cluster_master_role"
  assume_role_policy = data.aws_iam_policy_document.iam_policy_document.json
  tags               = merge(var.common_tags, { Name = "${var.naming_prefix}-eks-master-role" })
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  role       = aws_iam_role.eks_cluster_master_role.name
  policy_arn = data.aws_iam_policy.eks_cluster_master_policy.arn
}

resource "aws_iam_role_policy_attachment" "iam_role_eks_vpc_policy_attachment" {
  role       = aws_iam_role.eks_cluster_master_role.name
  policy_arn = data.aws_iam_policy.eks_cluster_vpc_policy.arn
}