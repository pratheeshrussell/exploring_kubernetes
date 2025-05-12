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

## Setup Percona Operator

[Refer percona.md](k8s/operators/percona.md)

## Add Ingress controller

[Refer ingress.md](k8s/ingress/README.md)

## Deploy the apps

```sh
cd k8s/overlays/local
kubectl apply -k .
```

## Access the apps
- Frontend: http://localhost:8080/frontend
- Backend: http://localhost:8080/backend/api/quotes/random
- PgAdmin: http://localhost:8080/pgadmin

