#! /bin/bash

echo "Hello world, from VPC"
aws cloudformation create-stack --stack-name "eks-vpc" \
	--template-body file://networkinfra.yml \
	--parameters file://networkinfra-params.json \
	--capabilities CAPABILITY_NAMED_IAM \
	--region=us-west-2
