# 1. Add the Datadog Helm repository
helm repo add datadog https://helm.datadoghq.com
helm repo update

# 2. Download and untar the Datadog Operator chart to inspect its values
helm pull datadog/datadog-operator --untar --destination ./temp-datadog-operator-chart
