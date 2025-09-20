#!/bin/bash

# 1️⃣ Додати тестовий рядок у файл
kubectl exec -n default promtail-qrrml -- sh -c "echo 'TEST LOG ENTRY $(date)' >> /var/log/test.log"

# 2️⃣ Дати Promtail трохи часу на зчитування
sleep 5

# 3️⃣ Перевірити через Loki API, чи рядок дійшов
curl -s -G "http://localhost:3100/loki/api/v1/query" \
--data-urlencode 'query={namespace="default"} |= "TEST LOG ENTRY"' | jq '.data.result'