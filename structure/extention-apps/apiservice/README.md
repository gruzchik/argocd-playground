

Go to https://github.com/bitnami-labs/sealed-secrets/releases

Copy the link to the controller.yaml and use wget to download it.

Use kubectl to apply the contents of the file to the cluster.

Go back to the downloads page and copy the link to the ***kubeseal-0.20.5-linux-amd64.tar.gz***

Use wget to download the file, move it to some directory in the $PATH variable and add the execute permissions:
```
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.20.5/kubeseal-0.20.5-linux-amd64.tar.gz
tar -xvf kubeseal-0.20.5-linux-amd64.tar.gz
sudo mv kubeseal /usr/local/bin
sudo chmod +x /usr/local/bin/kubeseal
```
Create a new directory in the myapp directory called apiservice:
```
mkdir apiservice
```
Inside the directory, create a deployment.yaml file and add the following content:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: busybox-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: busybox
  template:
    metadata:
      labels:
        app: busybox
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ["sh", "-c", "while true; do sleep 3600; done"]
        env:
        - name: APIKEY
          valueFrom:
            secretKeyRef:
              name: appsecret
              key: apikey
      restartPolicy: Always
```
Encode the dummy API key into base64 format:
```
echo api_key_2a6f1d23eabc482f9032165de5a8c7 | base64
```
Create a new file called secret.yaml and add the following:
```
apiVersion: v1
kind: Secret
metadata:
  name: appsecret
type: Opaque
data:
  apikey: YXBpX2tleV8yYTZmMWQyM2VhYmM0ODJmOTAzMjE2NWRlNWE4Yzc=
```
Get the public key using
```
kubeseal --fetch-cert > publickey.pem
```
Encrypt the contents of the secret using the following command:
```
kubeseal --format=yaml --cert=publickey.pem < secret.yaml > sealedsecret.yaml
```
View the file contents:
```
cat sealedsecret.yaml
```
Copy the encrypted string and try to decode it using base64.

Delete the secret file:
```
rm secret.yaml
rm publickey.pem
```
Create a new application in the argo-cd directory:
```
cd ../argo-cd
vim apiservice.yaml
```
The file contents should be as follows:
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: apiservice
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://gitlab.com/[username]/samplegitopsapp.git'
    path: apiservice
    targetRevision: main
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: default
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
```
Create a branch and an MR:
```
git checkout -b "adds-apiservice"
git add -A
git commit -m "Creates the API service and the sealed secret"
git push --set-upstream origin feature/adds-apiservice
```
Create and approve the MR from the link.

Go to the Argo CD UI and refresh the argo cd applcation.
