# Kubernetes Cluster admin docker

## Supported Cluster

* Amazon EKS

## Supported Cluster Command

* aws
* kubectl
* helm
* linkerd

## Configure

// todo
docker run -it diginex/k8s-admin init | sh

## Usage

```sh
docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin <<command>>
```

## Example Command

```sh
docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin kubectl get pods
docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin linkerd version
docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin aws
docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin helm version
```

// todo see if we can do docker run diginex/k8s-admin | sh kubectl get pods to eliminate the need of mount and -it.

## Proxy connection to the cluster

docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf -p 8080:8080 diginex/k8s-admin kubectl proxy --address 0.0.0.0 --accept-hosts '.*' --port 8080

// todo see if we can do something like this: docker run diginex/k8s-admin proxy | sh

## Dashbaord

### Linkerd

<http://127.0.0.1:8080/api/v1/namespaces/linkerd/services/web:http/proxy/>

### Grafana

<http://127.0.0.1:8080/api/v1/namespaces/linkerd/services/grafana:http/proxy/>