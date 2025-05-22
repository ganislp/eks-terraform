data "aws_iam_policy" "eks_worker_node_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

data "aws_iam_policy" "eks_worker_node_cni_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

data "aws_iam_policy" "eks_worker_node_container_ecr_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

data "aws_iam_policy_document" "eks_worker_node_policy_doc" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_worker_node_role" {
  name               = "eks_worker_node_role"
  assume_role_policy = data.aws_iam_policy_document.eks_worker_node_policy_doc.json
  tags               = merge(var.common_tags, { Name = "${var.naming_prefix}-eks-worker-node-role" })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_role_att" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = data.aws_iam_policy.eks_worker_node_policy.arn
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_role_cni_att" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = data.aws_iam_policy.eks_worker_node_cni_policy.arn
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_role_cni_ecr" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = data.aws_iam_policy.eks_worker_node_container_ecr_policy.arn
}