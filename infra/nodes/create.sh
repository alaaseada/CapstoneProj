#! /bin/bash

echo "Hello world! from nodes"

sed "s/replaceclustername/$1/g" nodes-params.json

aws cloudformation wait stack-create-complete --stack-name "eks-cluster"

aws cloudformation create-stack --stack-name "eks-nodes" \
	--template-body file://nodes.yml \
	--parameters file://nodes-params.json \
	--capabilities CAPABILITY_NAMED_IAM \
	--region=us-west-2
