Connect to multiple clusters from ArgoCD:

# argocd login --insecure --port-forward --port-forward-namespace=argocd --plaintext(with user and pass)

# argocd cluster add kind-primary –name primary --kubeconfig ./primary

# argocd cluster add kind-primary –name secondary --kubeconfig ./secondary

Where primary.txt and secondary.txt are result of ‘cat ${HOME}/.kube/config’ fir re,pte clusters
