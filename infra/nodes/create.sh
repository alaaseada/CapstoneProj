#! /bin/bash

echo "Hello world! from nodes"

aws cloudformation wait stack-create-complete --region us-west-2 --stack-name "eks-cluster"

nodes_StackId=$(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE --query "StackSummaries[?StackName=='eks-nodes'].StackId" --output text --region us-west-2)
echo $nodes_StackId

if [ -z "$nodes_StackId" ]
then
	aws cloudformation create-stack --stack-name "eks-nodes" \
		--template-body file://nodes.yml \
		--parameters file://cluster-nodes-params.json \
		--capabilities CAPABILITY_NAMED_IAM \
		--region=us-west-2
else
	echo "The stack \"eks-nodes\" is already exists"
fi
