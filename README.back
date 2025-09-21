# Monitoring Stack for Project

This repository contains Kubernetes manifests to deploy a full monitoring stack:

- OpenTelemetry Collector
- Prometheus
- Grafana Loki
- Promtail
- Grafana

The stack collects metrics and logs from your project and cluster nodes.

---

## 🚀 Deployment

Apply all manifests at once:

```bash
kubectl apply -f manifests/ -R
```

The `manifests/` folder contains:

- `otel-collector.yaml`
- `prometheus.yaml`
- `grafana.yaml`
- `loki.yaml`
- `promtail.yaml`

Check that all pods are running:

```bash
kubectl get pods -n default
```

---

## ⚙️ Configure Grafana Datasources

Open Grafana UI:

```bash
kubectl port-forward svc/grafana 3000:3000 -n default
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

Add Data Sources:

- **Prometheus** → `http://prometheus:9090`
- **Loki** → `http://loki:3100`

In Grafana: *Configuration → Data Sources → Add data source*

---

## 📊 Import Demo Dashboard

1. Go to *Dashboards → Manage → Import*  
2. Choose the file: `dashboards/demo-logs-metrics.json`  
3. Set Datasource mapping:  
   - `PROMETHEUS_DS` → Prometheus  
   - `LOKI_DS` → Loki  
4. Click **Import**

You will see a dashboard with:

- CPU and Memory metrics of your Pods  
- Logs from your project and cluster nodes  

---

## 🖼️ Demo Dashboard Screenshot

After importing the dashboard, you should see something like this:

![Grafana Dashboard](https://github.com/andreysvirid/monitoring-stack/blob/main/images/grafana1.png?raw=true)

---

## 🔍 Explore Logs

Open Grafana → **Explore → Loki** and run a query:

```logql
{job="your-app"} |= ""
```

This shows all logs as strings, avoiding “Data is missing a string field” issues.

---

## ✅ Notes

- Ensure Promtail is deployed and correctly collecting logs from all Pods and nodes.  
- Make sure the correct Data Sources are selected in Dashboard panels.  
- You can customize the dashboard to add additional metrics or log queries.