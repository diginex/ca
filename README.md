# Kubernetes Cluster admin docker

## TODOs

* A tool to query chart name for the project. (Chart detector).
* A tool to place chart values.yaml and place in project.
* A tool to init .gitlab-ci.yaml into the project.
* A tool to automatically substitute parameters in values.yaml with a predifined list of parameters.

## Supported Cluster Type

* Amazon EKS
* Kops on AWS

## Supported Cluster Command

* aws
* kubectl
* helm
* linkerd
* kops

## Install

```sh
docker run --rm diginex/ca install | sudo sh
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

## Required field for EKS Cluster Admin

* aws_access_key_id
* aws_secret_access_key
* aws_default_region
* kube_cluster_name

## Required fields for KOPS Cluster Admin

* aws_access_key_id
* aws_secret_access_key
* aws_default_region
* kops_cluster_name
* kops_state_store

### Export KOPS CA data

```sh
ca export_ca_data
```

## Required fields for KOPS Cluster Normal Usage

* aws_access_key_id
* aws_secret_access_key
* aws_default_region
* kops_cluster_name
* kops_ca_data
* kops_operation_role [KubernetesAdmin, Developer]

## Proxy API connection

```sh
docker run --rm -it -v $HOME/.ca/cluster.conf:/conf/cluster.conf -p 8080:8080 diginex/ca kubectl proxy --address 0.0.0.0 --accept-hosts '.*' --port 8080
```

## Proxy Service connection

```sh
docker run --rm -it -v $HOME/.ca/cluster.conf:/conf/cluster.conf -p 5601:5601 diginex/ca kubectl port-forward --namespace elastic svc/elastic-kibana --address 0.0.0.0 5601:443
```

## Dashbaord

After proxy created, we can view dashboard via proxy such as:
<http://localhost:8080/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login>

### Linkerd

<http://localhost:8080/api/v1/namespaces/linkerd/services/web:http/proxy/>

### Grafana

<http://localhost:8080/api/v1/namespaces/linkerd/services/grafana:http/proxy/>

## About Diginex

![Diginex Logo](https://www.diginex.com/wp-content/uploads/2018/09/diginex_chain_logo_-01-copy.png)

Diginex develops and implements blockchain technologies to transform businesses and enrich society. At the core of Diginex is our people. We are a blend of financial service professionals, passionate blockchain technologists and experienced project managers. We work with corporates, institutions & governments to create solutions that build trust and increase efficiency.