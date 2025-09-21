#!/bin/bash
# devops-check.sh
# Универсальный скрипт для проверки состояния Kubernetes, Helm, Flux, мониторинга и трассировок

NAMESPACE=${1:-default}   # Если namespace не указан, используется default
FLUX_NS="flux-system"

echo "=============================="
echo "1️⃣ Текущий контекст и namespace"
kubectl config current-context
kubectl config view --minify | grep namespace || echo "Namespace: default"

echo "=============================="
echo "2️⃣ Проверка нод и ресурсов"
kubectl get nodes -o wide
kubectl top nodes

echo "=============================="
echo "3️⃣ Состояние Pods в namespace: $NAMESPACE"
kubectl get pods -n $NAMESPACE -o wide
kubectl top pods -n $NAMESPACE

echo "=============================="
echo "4️⃣ Проверка всех сервисов"
kubectl get svc -n $NAMESPACE

echo "=============================="
echo "5️⃣ Проверка событий последних 100 событий"
kubectl get events -n $NAMESPACE --sort-by=.lastTimestamp | tail -n 100

echo "=============================="
echo "6️⃣ Проверка Helm releases"
helm list -n $NAMESPACE
flux get helmrelease -A

echo "=============================="
echo "7️⃣ Проверка Kustomizations (Flux)"
kubectl get kustomizations -A

echo "=============================="
echo "8️⃣ Логи OTEL Collector"
kubectl logs deploy/otel-collector -n $NAMESPACE --tail=50

echo "=============================="
echo "9️⃣ Логи Promtail"
kubectl logs -l app=promtail -n $NAMESPACE --tail=50

echo "=============================="
echo "🔟 Проверка Grafana и Tempo (локальный порт-форвард)"
echo "Grafana: kubectl port-forward svc/grafana 3000:3000 -n $NAMESPACE"
echo "Tempo:   kubectl port-forward svc/tempo-query-frontend 3200:3200 -n tempo"
echo "После запуска перейдите в браузер: http://localhost:3000 (Grafana), http://localhost:3200 (Tempo)"

echo "=============================="
echo "✅ Скрипт завершен. Проверьте вывод и логи выше для диагностики кластера и мониторинга."
