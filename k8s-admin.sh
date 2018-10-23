#!/bin/sh
docker run --rm -it -v $HOME/.ca/cluster.conf:/conf/cluster.conf diginex/ca "$@"