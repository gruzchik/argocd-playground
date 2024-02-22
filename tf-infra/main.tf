terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.0.19"
    }
  }
}


# provider "kind" {}

# resource "kind_cluster" "default" {
#     name = "test-cluster"
#     kind_config =<<KIONF
# kind: Cluster
# apiVersion: kind.x-k8s.io/v1alpha4
# nodes:
# - role: control-plane
#   kubeadmConfigPatches:
#   - |
#     kind: InitConfiguration
#     nodeRegistration:
#       kubeletExtraArgs:
#         node-labels: "ingress-ready=true"
#   extraPortMappings:
#   - containerPort: 80
#     hostPort: 80
#     protocol: TCP
#   - containerPort: 443
#     hostPort: 443
#     protocol: TCP
# KIONF
# }

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

#     kind_config = <<KIONF
# kind: Cluster
# apiVersion: kind.x-k8s.io/v1alpha4
# nodes:
# - role: control-plane
# - role: worker
# KIONF
}