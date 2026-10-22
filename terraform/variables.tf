variable "aws_region" {
  description = "AWS region where the EKS cluster will be created."
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS Kubernetes cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS managed node group."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type used for Kubernetes worker nodes."
  type        = string
}

variable "min_size" {
  description = "Minimum number of worker nodes."
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes."
  type        = number
}

variable "desired_size" {
  description = "Desired number of worker nodes."
  type        = number
}