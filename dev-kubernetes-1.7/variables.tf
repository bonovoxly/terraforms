# kubernetes demo

# variable for dns zone
variable "dns" {
  type = "string"
  default = "dev.example.internal"
}

# variable to identify environment
variable "env" {
  type = "string"
  default = "dev"
}

# SSH key pair to use.  This needs to be in AWS.
variable "keypair" {
  type = "string"
  default = "dev"
}

# Kubernetes cluster ID name (helps find AWS tagged resources)
variable "kubernetes_cluster_id" {
 type = "string"
 default = "dev-kubernetes-17"
}

# AWS region
variable "region" {
  type = "string"
  default = "us-east-1"
}

# if you need to define tenancy
variable "tenancy" {
  type = "string"
  default = "default"
}

