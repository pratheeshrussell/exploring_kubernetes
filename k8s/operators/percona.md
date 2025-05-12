# Percona Postgres

## Clusterwide setup
```sh
kubectl create namespace pg-operator
# the namespace name is hardcoded in the yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/percona/percona-postgresql-operator/v2.6.0/deploy/cw-bundle.yaml -n pg-operator
```

## READ:
- https://docs.percona.com/percona-operator-for-postgresql/2.0/kubectl.html#prerequisites