#!/bin/sh
read -p "AWS Access Key :" aws_access_key_id </dev/tty
read -p "AWS Secret Access Key :" aws_secret_access_key </dev/tty
read -p "AWS Default Region (e.g. us-east-1) :" aws_default_region </dev/tty
read -p "EKS Cluster Name :" kube_cluster_name </dev/tty

mkdir -p ~/.ca
echo "aws_access_key_id=$aws_access_key_id" > ~/.ca/cluster.conf
echo "aws_secret_access_key=$aws_secret_access_key" >> ~/.ca/cluster.conf
echo "aws_default_region=$aws_default_region" >> ~/.ca/cluster.conf
echo "kube_cluster_name=$kube_cluster_name" >> ~/.ca/cluster.conf
echo "Configured!"