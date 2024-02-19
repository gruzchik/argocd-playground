# Creating helm-chjart from scratch

Create project from scratch

$ helm create httpd	# create help project

$ vim values.yaml		# update values

$ vim Chart.yaml		# update Chart config

$ helm package .		# save helm chart to the package .tgz

Run helm chart locally with curl:

# curl --request POST --form 'chart=@httpd-0.1.0.tgz' --user "[your username]:[your token]" https://gitlab.com/api/v4/projects/[your project id]/packages/helm/api/stable/charts
