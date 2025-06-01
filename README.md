# Terraform EKS with ALB Deployment

This project provides a Terraform configuration to deploy an Amazon Elastic Kubernetes Service (EKS) cluster integrated with an Application Load Balancer (ALB) on AWS.

## Overview

The configuration automates the provisioning of the following AWS resources:

- **EKS Cluster**: Managed Kubernetes cluster for containerized applications.
- **IAM Roles and Policies**: Necessary permissions for EKS and ALB operations.
- **ALB Controller**: Facilitates the management of ALBs within the Kubernetes cluster.
- **Networking Components**: VPC, subnets, and security groups to ensure secure and efficient networking.

## Prerequisites

Before deploying the infrastructure, ensure the following tools are installed and configured:

- [Terraform](https://www.terraform.io/downloads.html) (>= 1.0.0)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) (configured with appropriate credentials)
- [kubectl](https://kubernetes.io/docs/tasks/tools/) (for interacting with the EKS cluster)

## Usage

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/barbar-del/terraform_eks_alb.git
   cd terraform_eks_alb

Initialize Terraform:
terraform init

Review the Execution Plan:
terraform plan

Apply the Configuration:
terraform apply


Note: The provisioning process may take up to 25 minutes.

Configuration
The deployment is configured for the us-east-1 region by default. You can modify the region and other parameters in the providers.tf and variables.tf files as needed.

Default Values
Some key default values are pre-defined in the variables.tf file for convenience:

| Variable             | Default Value          | Description                            |
| -------------------- | ---------------------- | -------------------------------------- |
| `region`             | `"us-east-1"`          | AWS region for the EKS cluster         |
| `cluster_name`       | `"my-eks-cluster"`     | Name of the EKS cluster                |
| `vpc_cidr`           | `"10.0.0.0/16"`        | CIDR block for the VPC                 |
| `public_subnets`     | `["10.0.1.0/24", ...]` | List of public subnets across AZs      |
| `private_subnets`    | `["10.0.3.0/24", ...]` | List of private subnets across AZs     |
| `node_instance_type` | `"t3.medium"`          | EC2 instance type for EKS worker nodes |
| `desired_capacity`   | `2`                    | Default number of worker nodes         |


You can override any of these by passing -var flags in the CLI or using a terraform.tfvars file.

Project Structure
main.tf: Defines the primary infrastructure components, including the EKS cluster and associated resources.

providers.tf: Specifies provider configurations, such as AWS region and credentials.

variables.tf: Declares input variables for customizable parameters.

iam-policy.json: Contains IAM policy definitions required for the ALB controller.

modules/: Directory for modular Terraform configurations (if applicable).

the kubernetes configuration will change to the new cluster with  a local exec command

Cleanup
To destroy the infrastructure and avoid incurring charges:
terraform destroy


License
This project is licensed under the MIT License.