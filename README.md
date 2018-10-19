# Kubernetes Cluster admin docker

## Supported Cluster

* Amazon EKS

## Supported Cluster Command

* aws
* kubectl
* helm
* linkerd

## Configure

```sh
docker run -it diginex/k8s-admin init | sh
```

## Example Usage

```sh
docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin kubectl get pods
docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin linkerd version
docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin aws
docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin helm version
```

## Proxy connection to the cluster

docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf -p 8080:8080 diginex/k8s-admin kubectl proxy --address 0.0.0.0 --accept-hosts '.*' --port 8080

## Dashbaord

After proxy created, we can view dashboard via proxy such as:

### Linkerd

<http://127.0.0.1:8080/api/v1/namespaces/linkerd/services/web:http/proxy/>

### Grafana

<http://127.0.0.1:8080/api/v1/namespaces/linkerd/services/grafana:http/proxy/>

## About Diginex

![Diginex Logo](https://www.diginex.com/wp-content/uploads/2018/09/diginex_chain_logo_-01-copy.png)

Diginex develops and implements blockchain technologies to transform businesses and enrich society. At the core of Diginex is our people. We are a blend of financial service professionals, passionate blockchain technologists and experienced project managers. We work with corporates, institutions & governments to create solutions that build trust and increase efficiency.