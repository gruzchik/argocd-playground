cd ..

mkdir base

cp ../manifests/deployment.yaml ../manifests/service.yaml base

cd base

vim kustomization.yaml


---------
cd ..

mkdir overlays

cd overlays

vim kustomization.yaml

-----
kustomize build ./overlays/| kubectl apply -f -
-----

kubectl apply -k .

kubectl get pods

kubectl get service