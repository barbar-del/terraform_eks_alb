output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks.name
}

output "eks_nodes_ids" {
  description = "The name of the EKS nodes in the cluster"
  value = data.aws_autoscaling_groups.eks_nodes.names[0]
}

output "eks_endpoint" {
  value = data.aws_eks_cluster.eks_cluster.endpoint
}

output "eks_certificate_authority" {
  value = data.aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_auth_token" {
  value = data.aws_eks_cluster_auth.cluster_auth.token
}
output "eks_oidc_provider_arn" {
  description = "The ARN of the OIDC provider for the EKS cluster"
  value       =  aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

