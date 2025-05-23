output "cluster_certificate_authority_data" {
  value = module.eks_cluester.cluster_certificate_authority_data
}

output "cluster_id" {
  value = module.eks_cluester.cluster_id
}

output "cluster_endpoint" {
  value = module.eks_cluester.cluster_endpoint
}

output "cluster_oidc_issuer_url" {
  value = module.eks_cluester.cluster_oidc_issuer_url
}

output "cluster_name" {
  value = module.eks_cluester.eks_cluster_name
}

output "aws_iam_openid_connect_provider_arn" {
  value = module.eks_cluester.aws_iam_openid_connect_provider_arn
}

output "aws_iam_openid_connect_provider_extract_from_arn" {
  value = module.eks_cluester.aws_iam_openid_connect_provider_extract_from_arn
}