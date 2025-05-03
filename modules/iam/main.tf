# =============================
# EKS Cluster Role
# =============================

# Create the EKS Cluster Role
resource "aws_iam_role" "eks_cluster_role" {
  name = var.cluster_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

# the following policies are attached to the EKS Cluster Role

# Attach AmazonEKSBlockStoragePolicy to EKS Cluster Role
resource "aws_iam_role_policy_attachment" "eks_cluster_block_storage" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"
  role       = aws_iam_role.eks_cluster_role.name

  depends_on = [aws_iam_role.eks_cluster_role]
}

# Attach AmazonEKSClusterPolicy to EKS Cluster Role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name

  depends_on = [aws_iam_role.eks_cluster_role]
}

# Attach AmazonEKSComputePolicy to EKS Cluster Role
resource "aws_iam_role_policy_attachment" "eks_cluster_compute" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSComputePolicy"
  role       = aws_iam_role.eks_cluster_role.name

  depends_on = [aws_iam_role.eks_cluster_role]
}

# Attach AmazonEKSLoadBalancingPolicy to EKS Cluster Role
resource "aws_iam_role_policy_attachment" "eks_cluster_load_balancing" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
  role       = aws_iam_role.eks_cluster_role.name

  depends_on = [aws_iam_role.eks_cluster_role]
}

# Attach AmazonEKSNetworkingPolicy to EKS Cluster Role
resource "aws_iam_role_policy_attachment" "eks_cluster_networking" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
  role       = aws_iam_role.eks_cluster_role.name

  depends_on = [aws_iam_role.eks_cluster_role]
}

# =============================
# EKS Node Role
# =============================

# Create the EKS Node Role
resource "aws_iam_role" "eks_node_role" {
  name = var.node_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attach policies to the EKS Node Role

# Attach AmazonEKSWorkerNodePolicy to the Node Role
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

# Attach AmazonEKS_CNI_Policy to the Node Role
resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name

  depends_on = [aws_iam_role.eks_node_role]
}

# Attach AmazonEC2ContainerRegistryReadOnly to the Node Role
resource "aws_iam_role_policy_attachment" "eks_node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name

  depends_on = [aws_iam_role.eks_node_role]
}



