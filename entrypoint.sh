#!/bin/sh
prop () {
    grep "${1}" /conf/cluster.conf|cut -d'=' -f2-
}

if [ -z $1 ]
then
    echo "Please specify command to run. e.g. init, aws, kubectl, helm, linkerd\n"
    echo "To install:"
    echo "  docker run --rm diginex/ca install | sudo sh\n"
    echo "To init, please run: "
    echo "  ca init\n"
    echo "Usage:"
    echo "  ca kubectl get pods"
    exit 0
fi

if [ $1 = 'install' ]
then
    cat /install.sh
    exit 0
fi

if [ $1 = 'getScript' ]
then
    cat /ca.sh
    exit 0
fi

if [ $1 = 'init' ]
then
    cat /init.sh
    exit 0
fi

# TODO
#if [ $1 = 'createdeveloperns' ]
#then
#    /createdeveloperns.sh $2 $3
#    
#    exit 0
#fi

export PATH=$PATH:$HOME/.linkerd2/bin

file="/conf/cluster.conf"
if [ -f "$file" ]
then
    export AWS_ACCESS_KEY_ID=$(prop 'aws_access_key_id') 
    export AWS_SECRET_ACCESS_KEY=$(prop 'aws_secret_access_key') 
    export AWS_DEFAULT_REGION=$(prop 'aws_default_region')
    export KUBE_CLUSTER_NAME=$(prop 'kube_cluster_name')
    export KOPS_CLUSTER_NAME=$(prop 'kops_cluster_name')
    export KOPS_STATE_STORE=$(prop 'kops_state_store')
fi

if [ ! -z $KUBE_CLUSTER_NAME ]
then
    aws eks update-kubeconfig --name $KUBE_CLUSTER_NAME > /dev/null
    exec "$@"
    exit 0
fi

if [ ! -z $KOPS_CLUSTER_NAME ]
then
    kops export kubecfg --name ${KOPS_CLUSTER_NAME}
    exec "$@"
    exit 0
fi

exec "$@"