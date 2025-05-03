
# Inititial step, create the vpc to let the cluster be created on 
module "vpc" {
  source         = "./modules/vpc"
  region         = var.region
  cidr_block     = var.cidr_block
  private_subnet = var.private_subnet
  public_subnet  = var.public_subnet
  azs            = var.azs

}


# add region variable
module "iam" {
  source = "./modules/iam"
  depends_on = [ module.vpc ]
}

module "eks" {
  source = "./modules/eks"
  cluster_name   = var.cluster_name
  subnet_ip      = var.private_subnet[0]
  cluster_iam_policies = module.iam.eks_cluster_role_policy_attachments
  sg_group = module.vpc.eks_sg_group
  node_iam_policies = module.iam.eks_node_role_policy_attachments
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
  cluster_role_arn = module.iam.eks_cluster_role_arn
  node_role_arn = module.iam.eks_node_role_arn


  depends_on = [ module.iam, module.vpc ]
}

module "ingress_controller" {
  source = "./modules/ingress_controller"
  eks_oidc_provider_arn = module.eks.eks_oidc_provider_arn
  region               = var.region
  eks_cluster_name     = module.eks.eks_cluster_name
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.private_subnets
  depends_on = [ module.eks, module.vpc, module.iam ]
}
