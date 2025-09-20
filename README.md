Monitoring Stack for Project

This repository contains manifests to deploy a full monitoring stack in Kubernetes:

OpenTelemetry Collector

Prometheus

Grafana Loki

Prometheus

Promtail

Grafana

The stack collects metrics and logs from your project and cluster nodes.

🚀 Deployment

Apply all manifests:

kubectl apply -f manifests/ -R


Structure of manifests/:

otel-collector.yaml

prometheus.yaml

grafana.yaml

loki.yaml

promtail.yaml

Check that all pods are running:

kubectl get pods -n default

⚙️ Configure Grafana Datasources

Open Grafana UI:

kubectl port-forward svc/grafana 3000:3000 -n default


Open http://localhost:3000
 in your browser.

Add Data Sources:

Prometheus → http://prometheus:9090

Loki → http://loki:3100

In Grafana: Configuration → Data Sources → Add data source

📊 Import Demo Dashboard

Go to Grafana → Dashboards → Manage → Import

Choose the file: dashboards/demo-logs-metrics.json

Set Datasource mapping:

PROMETHEUS_DS → Prometheus

LOKI_DS → Loki

Click Import

You will see a Dashboard with:

CPU and Memory metrics of your Pods

Logs from your project and cluster nodes

🖼️ Demo Dashboard Screenshot

Create the screenshot in Grafana after importing the Dashboard and save as screenshots/demo-dashboard.png.

🔍 Explore Logs

Open Grafana → Explore → Loki

Query example:

{job="your-app"} |= ""


This shows all logs as strings to prevent missing field issues.

✅ Notes

Ensure Promtail is deployed and correctly collecting logs from all Pods and nodes.

Make sure the correct Data Sources are selected in Dashboard panels.

You can customize the dashboard to add additional metrics or log queries.
