#! /bin/bash

echo "Hello world, from VPC"
aws cloudformation create-stack --stack-name "eks-vpc" \
	--template-body file://networkInfra.yml \
	--parameters file://networkInfra-params.json \
	--capabilities CAPABILITY_NAMED_IAM \
	--region=us-west-2
