#!/bin/sh
prop () {
    grep "${1}" /conf/cluster.conf|cut -d'=' -f2-
}

if [ -z $1 ]
then
#    cat /ca.sh
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

export PATH=$PATH:$HOME/.linkerd2/bin
mkdir ~/.kube

file="/conf/cluster.conf"
if [ -f "$file" ]
then
    export KUBE_CLUSTER_NAME=$(prop 'kube_cluster_name')
    export KUBE_ENDPOINT_URL=$(prop 'kube_endpoint_url')
    export KUBE_BASE64_CA_CERT=$(prop 'kube_base64_ca_cert')
    export AWS_ACCESS_KEY_ID=$(prop 'aws_access_key_id') 
    export AWS_SECRET_ACCESS_KEY=$(prop 'aws_secret_access_key') 
    export AWS_DEFAULT_REGION=$(prop 'aws_default_region')
fi

sed -e "s;%%%KUBE_ENDPOINT_URL%%%;`printenv KUBE_ENDPOINT_URL`;g" -e "s;%%%KUBE_BASE64_CA_CERT%%%;`printenv KUBE_BASE64_CA_CERT`;g" -e "s;%%%KUBE_CLUSTER_NAME%%%;`printenv KUBE_CLUSTER_NAME`;g" /kube/kubeconfig.template > ~/.kube/config

exec "$@"
