variable "cluster_name" {
  description = "cluster name"
}
variable "sg_group" {
  description = "EKS SG"
  type        = string
}
variable "region" {
  description = "EKS cluster region for eks kube-config"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The VPC ID to use for the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to use for the EKS cluster"
  type        = list(string)
}

variable "eks_node_desired_size" {
  description = "Desired number of worker nodes"
  default     = 2
}

variable "eks_node_max_size" {
  description = "Maximum number of worker nodes"
  default     = 3
}

variable "eks_node_min_size" {
  description = "Minimum number of worker nodes"
  default     = 1
}

variable "cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS Cluster"
  type        = string
}

variable "node_role_arn" {
  description = "The ARN of the IAM role for the EKS Node Group"
  type        = string
}


variable "cluster_iam_policies" {
  description = "IAM policies to attach to the EKS cluster role"
  type        = map(string)
}

variable "node_iam_policies" {
  description = "IAM policies to attach to the EKS node role"
  type        = map(string)
}

variable "subnet_ip" {
  description = "Subnet IP where the EC2 instance will be created"
  type        = string
}

