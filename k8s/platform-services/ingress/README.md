# Ingress

## Nginx Ingress Controller

### With helm 
```sh
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update

helm install kube-ingress-nginx ingress-nginx/ingress-nginx --version 4.15.1 --namespace ingress-nginx --create-namespace --set controller.hostPort.enabled=true --set controller.service.type=NodePort --set controller.ingressClassResource.default=true
```

### With kubectl
```sh
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
```
