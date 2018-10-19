#!/bin/sh
docker run -it -v $HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin "$@"