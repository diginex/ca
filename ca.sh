#!/bin/sh

if [ -z $1 ]
then
    docker run diginex/ca
fi

if [ $1 = 'init' ]
then
    docker run diginex/ca init | sh
    exit 0
fi

docker run -it -v ~/.ca/cluster.conf:/conf/cluster.conf -v $(pwd):/workspace diginex/ca $@