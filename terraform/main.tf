terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Find the existing default VPC in the selected AWS region.
data "aws_vpc" "default" {
  default = true
}

# Find the subnets belonging to the default VPC.
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name = "availability-zone"
    values = [
      "us-east-1a",
      "us-east-1b",
      "us-east-1c",
      "us-east-1d",
      "us-east-1f"
    ]
  }
}

# Create the EKS Kubernetes cluster and its managed worker nodes.
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.25.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  # Reuse the existing default VPC and its subnets.
  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.default.ids

  # Allow public API access from any IPv4 address for this learning project.
  endpoint_public_access       = true
  endpoint_public_access_cidrs = ["0.0.0.0/0"]

  # Give the identity running Terraform administrative access to the cluster.
  enable_cluster_creator_admin_permissions = true

  # Create a small managed node group for learning.
  eks_managed_node_groups = {
    voting = {
      name           = var.node_group_name
      instance_types = [var.instance_type]

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Project     = "Voting-App-Capstone"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}