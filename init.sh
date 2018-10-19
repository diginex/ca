#!/bin/sh

read -p "AWS Access Key:" aws_access_key_id </dev/tty
read -p "AWS Secret Access Key:" aws_secret_access_key </dev/tty
read -p "AWS Default Region (e.g. us-east-1):" aws_default_region </dev/tty
read -p "EKS Cluster Name:" kube_cluster_name </dev/tty
read -p "EKS Cluster Endpoint URL:" kube_endpoint_url </dev/tty
read -p "EKS Cluster Base64 CA Cert.:" kube_base64_ca_cert </dev/tty

mkdir -p ~/.k8s-admin
echo "aws_access_key_id=$aws_access_key_id" > ~/.k8s-admin/cluster.conf
echo "aws_secret_access_key=$aws_secret_access_key" >> ~/.k8s-admin/cluster.conf
echo "aws_default_region=$aws_default_region" >> ~/.k8s-admin/cluster.conf
echo "kube_cluster_name=$kube_cluster_name" >> ~/.k8s-admin/cluster.conf
echo "kube_endpoint_url=$kube_endpoint_url" >> ~/.k8s-admin/cluster.conf
echo "kube_base64_ca_cert=$kube_base64_ca_cert" >> ~/.k8s-admin/cluster.conf
echo "Configured!"