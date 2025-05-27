resource "aws_eks_addon" "aws_eks_addon" {
  depends_on               = [aws_iam_role_policy_attachment.iam_role_policy_att]
  cluster_name             = data.terraform_remote_state.eks.outputs.cluster_id
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.ebs_cis_iam_role.arn
}