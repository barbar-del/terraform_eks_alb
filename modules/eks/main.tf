# ===========================================
# EKS Cluster
# ===========================================

# define the cluster , can change the name in the variable.tf file
# and the region in the variable.tf file
resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = "1.31"  # k8s version
  vpc_config {
    security_group_ids = [var.sg_group]
    subnet_ids = var.subnet_ids  # Use the subnet_ids variable
  }
  provisioner "local-exec" {
    # Change kube config so the cluster controll will be available
    command = "sleep 5 && aws eks update-kubeconfig --name ${self.name} --region ${var.region}" 
  }
  depends_on = [
   var.cluster_iam_policies
  ]
}

# OUTPUT THIS SECURITY GRUOP SO I WILL BE ABLE TO ADD RULES TO THE NODES AND ALB

data "aws_security_group" "eks_sg" {
  id = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}

# ===========================================
# EKS Node Group
# ===========================================

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name  = aws_eks_cluster.eks.name
  node_role_arn  = var.node_role_arn  # Use the eks_node_role_arn variable
  subnet_ids     = var.subnet_ids          # Use the subnet_ids variable
  instance_types = ["t3.medium"]


  #can chane the spesific number of node 
  scaling_config {
    desired_size = var.eks_node_desired_size
    max_size     = var.eks_node_max_size
    min_size     = var.eks_node_min_size
  }
   depends_on = [
    var.node_iam_policies,
    aws_eks_cluster.eks
  ]
}


# ===========================================
# Data Sources for EKS Cluster Auth
# ===========================================
data "aws_eks_cluster" "eks_cluster" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.eks.name
}
# Data source that looks up Auto Scaling Groups
data "aws_autoscaling_groups" "eks_nodes" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = [aws_eks_node_group.eks_nodes.node_group_name]
  }

  filter {
    name   = "tag:eks:cluster-name"
    values = [var.cluster_name]
  }

  depends_on = [aws_eks_node_group.eks_nodes]
}

# ===========================================
# EKS Add-ons
# ===========================================

# VPC CNI Add-on
resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "vpc-cni"
  addon_version = "v1.19.2-eksbuild.5"  # Update to latest compatible version
  
  # Ensure the cluster exists before creating the addon
  depends_on = [
    aws_eks_cluster.eks
  ]
}

# CoreDNS Add-on
resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "coredns"
  addon_version = "v1.11.4-eksbuild.2"  # Update to latest compatible version
  
  # CoreDNS requires nodes to be available
  depends_on = [
    aws_eks_node_group.eks_nodes
  ]
}

# kube-proxy Add-on
resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "kube-proxy"
  addon_version = "v1.31.3-eksbuild.2"  # Use version aligned with your EKS 1.31
  
  depends_on = [
    aws_eks_cluster.eks
  ]
}


#_____note for reader______
# you can  add more addons but it  need to be in a spesific order, so if needed add depends_on to the other 
# spesialy if core dns is needed (coredns dd on)

# ===========================================
