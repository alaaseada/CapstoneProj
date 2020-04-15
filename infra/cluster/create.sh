#! /bin/bash

echo "Hello world! from cluster"
aws cloudformation wait stack-create-complete --stack-name "eks-vpc"

aws cloudformation create-stack \
	--stack-name "eks-cluster" \
	--template-body file://clusterinfra.yml \
	--parameters file://clusterinfra-params.json \
	--capabilities CAPABILITY_NAMED_IAM \
	--region=us-west-2
