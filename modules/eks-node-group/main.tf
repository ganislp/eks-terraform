
locals {
  node_group_name_private =  "${var.naming_prefix}-${var.eks_cluster_name}-private-node-group"
  node_group_name_public =  "${var.naming_prefix}-${var.eks_cluster_name}-public-node-group"
}
resource "aws_eks_node_group" "eks_public_node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = local.node_group_name_public
  node_role_arn   = aws_iam_role.eks_worker_node_role.arn
  subnet_ids      =  tolist(var.public_subnets) 
  ami_type        = "AL2_x86_64"
  instance_types  = tolist(var.instance_types)
  capacity_type   = var.capacity_type
  disk_size       = 20

  scaling_config {
    max_size     = 2
    desired_size = 1
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = var.key_name
  }

  tags = merge(var.common_tags, { Name = "${local.node_group_name_public}" })

}

# resource "aws_eks_node_group" "eks_private_node_group" {
#   cluster_name    = var.eks_cluster_name
#   node_group_name = local.node_group_name_private
#   node_role_arn   = aws_iam_role.eks_worker_node_role.arn
#   subnet_ids      =  tolist(var.private_subnets)
#   ami_type        = "AL2_x86_64"
#   instance_types  = tolist(var.instance_types)
#   capacity_type   = var.capacity_type
#   disk_size       = 20

#   scaling_config {
#     max_size     = 2
#     desired_size = 1
#     min_size     = 1
#   }

#   remote_access {
#     ec2_ssh_key = var.key_name
#   }

#   tags = merge(var.common_tags, { Name = "${local.node_group_name_private}" })

# }
