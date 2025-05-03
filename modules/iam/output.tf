output "eks_cluster_role_arn" {
  description = "IAM Role ARN for the EKS Cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "IAM Role ARN for the EKS Node Group"
  value       = aws_iam_role.eks_node_role.arn
}

output "eks_cluster_role_policy_attachments" {
  description = "IAM policy attachments for the EKS cluster role"
  value = {
    block_storage     = aws_iam_role_policy_attachment.eks_cluster_block_storage.policy_arn
    cluster_policy    = aws_iam_role_policy_attachment.eks_cluster_policy.policy_arn
    compute_policy    = aws_iam_role_policy_attachment.eks_cluster_compute.policy_arn
    load_balancing    = aws_iam_role_policy_attachment.eks_cluster_load_balancing.policy_arn
    networking_policy = aws_iam_role_policy_attachment.eks_cluster_networking.policy_arn
  }
}


output "eks_node_role_policy_attachments" {
  description = "IAM policy attachments for the EKS node role"
  value = {
    cni_policy           = aws_iam_role_policy_attachment.eks_node_AmazonEKS_CNI_Policy.policy_arn
    ecr_readonly         = aws_iam_role_policy_attachment.eks_node_AmazonEC2ContainerRegistryReadOnly.policy_arn
  }
}

