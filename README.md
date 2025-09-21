# Monitoring Stack for Project

This repository contains Kubernetes manifests to deploy a full monitoring stack:

- **OpenTelemetry Collector**
- **Prometheus**
- **Grafana Loki**
- **Promtail**
- **Grafana**
- **Tempo** (for distributed traces)

The stack collects metrics, logs, and traces from your project and cluster nodes.

---

## 🚀 Deployment

### Apply manifests in Kubernetes

Apply all manifests at once:

```bash
kubectl apply -f manifests/ -R
The manifests/ folder contains:

otel-collector.yaml

prometheus.yaml

grafana.yaml

loki.yaml

promtail.yaml

tempo.yaml

Check that all pods are running:


kubectl get pods -n monitoring
Note: All resources are deployed in the monitoring namespace to avoid conflicts.

⚙️ Flux / GitOps Deployment
If using Flux, ensure the Git repository and branch are configured:


flux create source git monitoring-stack \
  --url=https://github.com/andreysvirid/monitoring-stack.git \
  --branch=main \
  --interval=1m
Deploy Helm charts via Flux:


flux create helmrelease monitoring-stack \
  --source=GitRepository/monitoring-stack \
  --chart=prometheus \
  --interval=5m
Check HelmReleases status:


flux get helmrelease -A
⚙️ Configure Grafana Datasources
Open Grafana UI:


kubectl port-forward svc/grafana 3000:3000 -n monitoring
Open http://localhost:3000 in your browser.

Add Data Sources:

Prometheus → http://prometheus:9090

Loki → http://loki:3100

Tempo → http://tempo-query-frontend:3200

In Grafana: Configuration → Data Sources → Add data source

📊 Import Demo Dashboard
Go to Dashboards → Manage → Import

Choose the file: dashboards/demo-logs-metrics.json

Set Datasource mapping:

PROMETHEUS_DS → Prometheus

LOKI_DS → Loki

TEMPO_DS → Tempo

Click Import

You will see a dashboard with:

CPU and Memory metrics of your Pods

Logs from your project and cluster nodes

Distributed traces from Otel-instrumented applications

🔍 Explore Logs and Traces
Logs:
Open Grafana → Explore → Loki and run:


{job="your-app"} |= ""
Traces:
Open Grafana → Explore → Tempo and run a TraceQL query:


service.name = "current-version-api" | limit 20
Ensure the OpenTelemetry Collector is configured to export traces to Tempo:


exporters:
  tempo:
    endpoint: "tempo:4317"
service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch]
      exporters: [tempo]
Check Collector logs for traces:


kubectl logs -n monitoring deploy/otel-collector
You should see trace/log events from your demo application.

✅ Notes
Deploy all components in the monitoring namespace to avoid conflicts.

Ensure Promtail collects logs from all Pods and cluster nodes.

Make sure the correct Data Sources are selected in Dashboard panels.

You can customize dashboards to add additional metrics, log queries, and trace visualizations.

Use Flux for GitOps-based continuous deployment if required.

Verify traces are exported to Tempo and visible in Grafana.