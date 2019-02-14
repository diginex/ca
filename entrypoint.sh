#!/bin/bash
prop () {
    grep "${1}" /conf/cluster.conf|cut -d'=' -f2-
}

source ~/.profile

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

if [ $1 = 'deploy' ]
then
    cat /deploy.sh
    exit 0
fi

if [ $1 = 'deploychart' ]
then
    cat /deploychart.sh
    exit 0
fi

if [ $1 = 'builddeploydocker' ]
then
    cat /builddeploydocker.sh
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
    export KOPS_CA_DATA=$(prop 'kops_ca_data')
    export KOPS_OPERATION_ROLE=$(prop 'kops_operation_role')

fi

if [ ! -z $KUBE_CLUSTER_NAME ]
then
    aws eks update-kubeconfig --name $KUBE_CLUSTER_NAME > /dev/null
    exec "$@"
    exit 0
fi

if [ ! -z $KOPS_CLUSTER_NAME ]
then
    if [ ! -z $KOPS_CA_DATA ]
    then
        ACCOUNT_ID=$(aws sts get-caller-identity --output text --query 'Account')
        sed -e "s;%%%KOPS_CA_DATA%%%;$KOPS_CA_DATA;g" -e "s;%%%KOPS_CLUSTER_NAME%%%;$KOPS_CLUSTER_NAME;g" -e "s;%%%ACCOUNT_ID%%%;$ACCOUNT_ID;g" -e "s;%%%KOPS_OPERATION_ROLE%%%;$KOPS_OPERATION_ROLE;g" /kubeconfig.template.yaml | install -D /dev/stdin ~/.kube/config
        exec "$@"
        exit 0
    fi

    if [ -z $SUPPRESS_INFO ]
    then
        kops export kubecfg --name ${KOPS_CLUSTER_NAME}
    else
        kops export kubecfg --name ${KOPS_CLUSTER_NAME} > /dev/null
    fi
    exec "$@"
    exit 0
fi

exec "$@"