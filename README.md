# Basic Kubernetes Cluster Setup For Local Dev

## Pre Requisites
- docker
- kubectl
- kind

## Build the images
```sh
cd app-code
./build-img.sh
```
## Create Kind Cluster

```sh
cd k8s
kind create cluster --config kind/config.yaml
```

## Load images

```sh
kind load docker-image quote-backend --name kube-lab-cluster

# optionally pull these images locally first or else it will pull these from dockerhub
kind load docker-image nginx:alpine dpage/pgadmin4 bitnami/kubectl:latest percona/percona-postgresql-operator:2.6.0-ppg17.4-postgres percona/percona-postgresql-operator:2.6.0-ppg17.4-pgbackrest2.54.2 percona/percona-postgresql-operator:2.6.0-ppg17.4-pgbouncer1.24.0 --name kube-lab-cluster
```

## Add Crossplane
[Refer crossplane.md](k8s/platform-services/crossplane/crossplane.md)

This uses a `bootstrap.sh` script to set up in three stages:
1. `01-providers`: Installs the Helm Provider and Functions.
2. `02-infrastructure`: Uses the Helm Provider to install Percona Operator, NGINX Ingress, and Argo CD.
3. `03-apis`: Installs Custom APIs (XRDs and Compositions).

## Deploy the apps

```sh
cd k8s/overlays/local
kubectl apply -k .
```

## Access the apps
- Frontend: http://localhost:8080/frontend
- Backend: http://localhost:8080/backend/api/quotes/random
- PgAdmin: http://localhost:8080/pgadmin

