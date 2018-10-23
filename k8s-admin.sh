#!/bin/sh
docker run -it -v $HOME/.ca/cluster.conf:/conf/cluster.conf diginex/ca "$@"