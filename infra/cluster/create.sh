#! /bin/bash

echo "Hello world! from cluster"

aws cloudformation wait stack-create-complete --region us-west-2 --stack-name "eks-vpc"

cluster_StackId=$(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE --query "StackSummaries[?StackName=='eks-cluster'].StackId" --output text --region us-west-2)
echo $cluster_StackId

if [ -z "$cluster_StackId" ]
then
	aws cloudformation create-stack \
		--stack-name "eks-cluster" \
		--template-body file://clusterinfra.yml \
		--parameters file://clusterinfra-params.json \
		--capabilities CAPABILITY_NAMED_IAM \
		--region=us-west-2
else
	echo "The stach \"eks-cluster\" is already exists"
fi
