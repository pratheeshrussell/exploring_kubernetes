#!/bin/sh
set -e

echo "Waiting for secret to be ready..."

# The secret to update
# this is the secret set by percona-operator
SECRET_NAME="postgres-user-secret"
SECRET_NAMESPACE="pg-cluster"
SECRET_KEY="password"


while true; do
  if kubectl get secret "$SECRET_NAME" -n "$SECRET_NAMESPACE" >/dev/null 2>&1; then
if kubectl get secret "$SECRET_NAME" -n "$SECRET_NAMESPACE" -o jsonpath="{.data.$SECRET_KEY}" | grep -q .; then
  echo "Secret and key found!"
  break
fi
  fi
  echo "Still waiting for secret..."
  sleep 2
done

echo "Patching Secret with new value..."

# The PG_ROOT_PASSWORD will be loaded as an environment variable in the container
kubectl patch secret "$SECRET_NAME" -n "$SECRET_NAMESPACE" -p "{\"stringData\":{\"password\":\"$PG_ROOT_PASSWORD\", \"verifier\":\"\"}}"

echo "Password update complete!"