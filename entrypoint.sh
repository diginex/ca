#!/bin/sh
prop () {
    grep "${1}" /conf/cluster.conf|cut -d'=' -f2-
}

if [ -z $1 ]
then
#    cat /k8s-admin.sh
    echo "Please specify command to run. e.g. init, aws, kubectl, helm, linkerd\n"
    echo "To init, please run: "
    echo "  docker run diginex/k8s-admin init | sh\n"
    echo "Usage:"
    echo "  docker run -it -v \$HOME/.k8s-admin/cluster.conf:/conf/cluster.conf diginex/k8s-admin kubectl get pods"
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
	echo "$file found. Use cluster.conf."
    export KUBE_CLUSTER_NAME=$(prop 'kube_cluster_name')
    export KUBE_ENDPOINT_URL=$(prop 'kube_endpoint_url')
    export KUBE_BASE64_CA_CERT=$(prop 'kube_base64_ca_cert')
    export AWS_ACCESS_KEY_ID=$(prop 'aws_access_key_id') 
    export AWS_SECRET_ACCESS_KEY=$(prop 'aws_secret_access_key') 
    export AWS_DEFAULT_REGION=$(prop 'aws_default_region')
else
	echo "$file not found. Use Environment Variable."
fi

sed -e "s;%%%KUBE_ENDPOINT_URL%%%;`printenv KUBE_ENDPOINT_URL`;g" -e "s;%%%KUBE_BASE64_CA_CERT%%%;`printenv KUBE_BASE64_CA_CERT`;g" -e "s;%%%KUBE_CLUSTER_NAME%%%;`printenv KUBE_CLUSTER_NAME`;g" ./kube/kubeconfig.template > ~/.kube/config

exec "$@"
