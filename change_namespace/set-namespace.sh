#!/bin/bash
# Добавление/замена namespace во всех YAML манифестах мониторинга

NAMESPACE=${1:-monitoring}  # по умолчанию "monitoring"

# Найти все YAML файлы в текущей папке и подкаталогах
find . -type f -name "*.yaml" | while read f; do
  echo "Обновляю namespace в $f"
  yq -i ".metadata.namespace = \"$NAMESPACE\"" "$f"
done

echo "Namespace обновлен на '$NAMESPACE' во всех YAML файлах"
