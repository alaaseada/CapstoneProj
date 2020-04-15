#! /bin/bash

echo "Hello world, from get cluster name script!"

aws cloudformation wait stack-create-complete --region us-west-2 --stack-name "eks-cluster" 

aws cloudformation describe-stacks \
	  --stack-name "eks-cluster" \
	  --query "Stacks[0].Outputs[?OutputKey=='eks-cluster-ClusterName'].OutputValue" \
	  --output text \
	  --region=us-west-2
