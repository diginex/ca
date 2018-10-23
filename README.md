# Kubernetes Cluster admin docker

## Supported Cluster

* Amazon EKS

## Supported Cluster Command

* aws
* kubectl
* helm
* linkerd

## Install

```sh
docker run diginex/ca install | sudo sh
```

## Configure

```sh
ca init
```

## Example Usage

```sh
ca kubectl get pods
ca linkerd version
ca aws
ca helm version
```

## Proxy connection to the cluster

```sh
docker run -it -v $HOME/.ca/cluster.conf:/conf/cluster.conf -p 8080:8080 diginex/ca kubectl proxy --address 0.0.0.0 --accept-hosts '.*' --port 8080
```

## Dashbaord

After proxy created, we can view dashboard via proxy such as:

### Linkerd

<http://127.0.0.1:8080/api/v1/namespaces/linkerd/services/web:http/proxy/>

### Grafana

<http://127.0.0.1:8080/api/v1/namespaces/linkerd/services/grafana:http/proxy/>

## About Diginex

![Diginex Logo](https://www.diginex.com/wp-content/uploads/2018/09/diginex_chain_logo_-01-copy.png)

Diginex develops and implements blockchain technologies to transform businesses and enrich society. At the core of Diginex is our people. We are a blend of financial service professionals, passionate blockchain technologists and experienced project managers. We work with corporates, institutions & governments to create solutions that build trust and increase efficiency.