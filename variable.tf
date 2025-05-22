variable "aws_region" {
  description = "AWS region to use for resources."
  type        = string
  default     = "us-east-1"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "CT"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
  default     = "Project"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources."
  default     = "demo"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
  default     = "dev"
}

variable "vpc_name" {
  type    = string
  default = "vpc-ecs"
}


variable "aws_azs" {
  type        = list(string)
  description = "AWS Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}

variable "vpc_cidr_block" {
  type        = string
  description = "Base CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnets_cidr_block" {
  type        = list(string)
  description = "CIDR Block for Public Subnets in VPC"
  default     = ["10.0.101.0/24"]
}

variable "instance_type" {
  description = "Type for EC2 Instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "tf-key"
}

variable "ec2_name" {
  type    = string
  default = "Bastion Host"
}

variable "sg_ingress_public" {
  type = list(object({
    description = string
    port        = number
  }))
  default = [
    {
      description = "Allows SSH access"
      port        = 22
    }
  ]
}

variable "eks_cluster_name" {
  type    = string
  default = "demo-eks"
}

variable "eks_cluster_version" {
  type    = string
  default = "1.31"
}

variable "eks_cluster_endpoint_private_access" {
  type    = bool
  default = false
}

variable "eks_cluster_endpoint_public_access" {
  type    = bool
  default = true
}

variable "eks_cluster_endpoint_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "eks_cluster_service_ipv4_cidr" {
  type    = string
  default = "172.20.0.0/16"
}

variable "capacity_type"{
  type = string
  default = "ON_DEMAND"
}



variable "instance_types" {
  type = list(string)
  default = [ "t2.micro" ]
}

variable "eks_node_group_public" {
  type = bool
  default = true
}

variable "eks_node_group_private" {
  type = bool
  default = true
}

variable "eks_cluster_node_group_name" {
  type = string
  default = "eks-node-group"
}
