terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.0.19"
    }
  }
}


provider "kind" {}

# creating a cluster with kind of the name "test-cluster" with kubernetes version v1.18.4 and two nodes
resource "kind_cluster" "default" {
    name = "test-cluster"
    node_image = "kindest/node:v1.18.4"
    kind_config {
        kind = "Cluster"
        api_version = "kind.x-k8s.io/v1alpha4"
        node {
            role = "control-plane"
            kubeadm_config_patches = [
                "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
            ]

            extra_port_mappings {
                container_port = 80
                host_port      = 80
            }
            extra_port_mappings {
                container_port = 443
                host_port      = 443
            }
        }
    }

}

resource "helm_release" "argocd" {
    name = "test-cluster"
    repository = "https://argoproj.github.io/argo-helm"
    chart = "argo-cd"
    namespace = "argocd"
    create_namespace = true
    version = "3.35.4"
    values = [file("values/argocd.yaml")]
}