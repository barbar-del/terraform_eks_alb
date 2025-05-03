variable "cluster_role_name" {
  description = "The name of the EKS cluster IAM role."
  type        = string
  default     = "eks-cluster-role"
}

variable "node_role_name" {
  description = "The name of the EKS node IAM role."
  type        = string
  default     = "eks-node-role"
}

variable "alb_controller_role_name" {
  description = "The name of the AWS Load Balancer Controller IAM role"
  type        = string
  default     = "eks-alb-controller-role"
}

