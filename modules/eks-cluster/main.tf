resource "aws_eks_cluster" "eks_cluester" {
  name     = var.eks_cluster_name
  version  = var.eks_cluster_version
  role_arn = aws_iam_role.eks_cluster_master_role.arn
  vpc_config {
    subnet_ids              = var.eks_cluster_endpoint_public_access ? tolist(var.public_subnets) : tolist(var.private_subnets)
    endpoint_private_access = var.eks_cluster_endpoint_private_access
    endpoint_public_access  = var.eks_cluster_endpoint_public_access
    public_access_cidrs     = var.eks_cluster_endpoint_access_cidrs
  }
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  kubernetes_network_config {
    service_ipv4_cidr = var.eks_cluster_service_ipv4_cidr
  }

  depends_on = [aws_iam_role_policy_attachment.iam_role_policy_attachment,
  aws_iam_role_policy_attachment.iam_role_eks_vpc_policy_attachment]
  tags = merge(var.common_tags, { Name = "${var.naming_prefix}-${var.eks_cluster_name}" })
}

