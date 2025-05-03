variable "eks_oidc_provider_arn" {
    description = "The ARN of the EKS OIDC provider"
    type        = string
}

variable "region" {
    description = "The AWS region where the EKS cluster is deployed"
    type        = string
}

variable "eks_cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
}

variable "vpc_id" {
    description = "The VPC ID where the EKS cluster is deployed"
    type        = string
}
variable "subnet_ids" {
    description = "The list of subnet IDs where the EKS cluster is deployed"
    type        = list(string)
}