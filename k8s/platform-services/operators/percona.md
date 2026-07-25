# Percona Postgres

## Setup

### With helm 
```sh
helm repo add percona https://percona.github.io/percona-helm-charts/
helm repo update

helm install kube-pg-operator percona/pg-operator --version 2.6.0 --namespace pg-operator --create-namespace --set watchAllNamespaces=true
```

### With kubectl

```sh
kubectl create namespace pg-operator
# the namespace name is hardcoded in the yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/percona/percona-postgresql-operator/v2.6.0/deploy/cw-bundle.yaml -n pg-operator
```

## READ:
- https://docs.percona.com/percona-operator-for-postgresql/2.0/kubectl.html#prerequisites