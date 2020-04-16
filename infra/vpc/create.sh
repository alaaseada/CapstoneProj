#! /bin/bash

echo "Hello world, from VPC"

vpc_StackId=$(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE --query "StackSummaries[?StackName=='eks-vpc'].StackId" --output text --region us-west-2)
echo $vpc_StackId

if [ -z "$vpc_StackId" ]
then
	aws cloudformation create-stack --stack-name "eks-vpc" \
		--template-body file://networkInfra.yml \
		--parameters file://networkInfra-params.json \
		--capabilities CAPABILITY_NAMED_IAM \
		--region=us-west-2
else
	echo "The stack \"eks-vpc\" is already exists"
fi
