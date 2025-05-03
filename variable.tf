variable "cluster_name" {
  description = "cluster name"
  default = "terraform_eks_cluster" 
}

# aws region for the cluster
variable "region" { 
    default = "us-east-1"
}

# Vpc sider 
variable "cidr_block" {
    default = "10.0.0.0/16"
}

# Subnet cider, can add more,just  mae sure the siders are correct
variable "private_subnet" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"]
    description = "private subnet"
}
# Public subnet cider
variable "public_subnet" {
    type = list(string)
    default = ["10.0.5.0/24", "10.0.6.0/24"]
    description = "Public subnet"
}

# Availability Zones, notice that 2 or more are a must
variable "azs" {
    type = list(string)
    description = "Availability Zones"
    default = [ "us-east-1a", "us-east-1b" ]
}

