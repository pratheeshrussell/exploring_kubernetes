# CrossPlane

## Setup
Setup crossplane
```sh
helm repo add crossplane-stable https://charts.crossplane.io/stable

helm repo update

helm install kube-crossplane --namespace crossplane-system --create-namespace crossplane-stable/crossplane --version 2.3.4
```
Add the providers, functions, infrastructure, and custom APIs:
```sh
cd k8s/platform-services/crossplane
./bootstrap.sh
```

## Providers
[Upbound Marketplace](https://marketplace.upbound.io/providers)
