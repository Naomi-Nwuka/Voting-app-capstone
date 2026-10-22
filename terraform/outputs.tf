output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Public API endpoint of the EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "region" {
  description = "AWS region containing the cluster."
  value       = var.aws_region
}

output "vpc_id" {
  description = "ID of the existing default VPC."
  value       = data.aws_vpc.default.id
}

output "subnet_ids" {
  description = "Subnet IDs used by the cluster."
  value       = data.aws_subnets.default.ids
}