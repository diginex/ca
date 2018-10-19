# Run

docker run -it -v $HOME/.diginex/devcluster.conf:/conf/deployer.conf josiahchoi/k8sdeployer linkerd version

## Proxy connection to the cluster

docker run -it -v $HOME/.diginex/devcluster.conf:/conf/deployer.conf -p 8080:8080 josiahchoi/k8sdeployer kubectl proxy --address 0.0.0.0 --accept-hosts '.*' --port 8080

## Dashbaord

### Linkerd

<http://127.0.0.1:8080/api/v1/namespaces/linkerd/services/web:http/proxy/>

### Grafana

<http://127.0.0.1:8080/api/v1/namespaces/linkerd/services/grafana:http/proxy/>