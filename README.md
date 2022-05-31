# Docker file for Hive Metastore

Minimal docker kerberos secured Hive Metastore server for testing purposes.\
Please be aware that kerberos is not embedded so [docker KDC](https://github.com/gaborgsomogyi/docker-kdc) is needed.

## How to build
```
eval $(minikube docker-env)
docker build -t gaborgsomogyi/hive:latest .
```

## How to run
Here one can choose from 2 deployments:
* K8S
```
mkdir -p ${HOME}/share
minikube start --mount-string="${HOME}/share:/share" --mount
kubectl apply -f hive.yaml
kubectl delete pod/hive
```

* Docker
```
./run-hive.sh
```

## Access the container
* K8S
```
kubectl exec -it hive -- bash
```

* Docker
```
docker exec -it hive bash
```
