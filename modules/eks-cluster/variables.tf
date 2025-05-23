variable "eks_cluster_name" {}
variable "eks_cluster_version" {}
variable "eks_cluster_service_ipv4_cidr" {}
variable "eks_cluster_endpoint_public_access" {}
variable "eks_cluster_endpoint_private_access" {}
variable "eks_cluster_endpoint_access_cidrs" {}
variable "common_tags" {}
variable "naming_prefix" {}
variable "private_subnets" {}
variable "public_subnets" {}
# EKS OIDC ROOT CA Thumbprint - valid until 2037
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}
