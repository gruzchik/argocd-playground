terraform {
  required_version = ">= 1.0"
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0" # Or the latest version you prefer
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0" # Or your desired version
    }
  }
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-kind" # Replace with your Kind cluster name (e.g., "kind-kind")
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-kind" # Replace with your Kind cluster name (e.g., "kind-kind")
}