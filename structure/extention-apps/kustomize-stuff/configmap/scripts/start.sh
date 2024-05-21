#! /bin/sh

# Expose k3d node port to localhost for testing (if you are using k3d on a mac)
#  k3d cluster create kustomize-test --servers=2 --agents=2 --port="30000-30010:30000-30010@loadbalancer"

# Create a namespace for the lecture
kubectl create ns cfgmap

# Set the current namespace to cfgmap
kubectl config set-context --current --namespace=cfgmap

# Apply the kustomization to the cluster
kubectl apply -k .

# Get the postgres database ip address
kubectl get svc/cfgmap-mysql --output="jsonpath={.spec.clusterIP}"