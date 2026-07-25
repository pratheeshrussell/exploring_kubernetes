#!/bin/bash
set -e

echo "🚀 Bootstrapping Crossplane Platform..."

echo "📦 Stage 1: Installing Providers and Functions..."
kubectl apply -k 01-providers

echo "⏳ Waiting for provider-helm to be healthy (this may take a minute)..."
kubectl wait --for=condition=Healthy provider.pkg.crossplane.io/upbound-provider-helm --timeout=120s

echo "⏳ Waiting for ProviderConfig CRD to be established..."
kubectl wait --for=condition=Established crd/providerconfigs.helm.crossplane.io --timeout=60s

echo "⚙️ Applying Helm ProviderConfig..."
# Re-apply 01-providers because ProviderConfig usually fails on the first run before CRDs exist
kubectl apply -k 01-providers

echo "🏗️ Stage 2: Installing Infrastructure (Argo CD, NGINX ingress, Percona)..."
kubectl apply -k 02-infrastructure

echo "🔗 Stage 3: Installing Custom APIs (XRDs and Compositions)..."
kubectl apply -k 03-apis

echo "✅ Bootstrap Complete!"
