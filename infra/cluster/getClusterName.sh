#! /bin/bash

echo "Hello world, from get cluster name script!"
aws cloudformation describe-stacks \
	  --stack-name "eks-cluster" \
	  --query "Stacks[0].Outputs[?OutputKey=='eks-cluster-ClusterName'].OutputValue" \
	  --output text
