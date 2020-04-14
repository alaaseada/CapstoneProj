#! /bin/bash

aws cloudformation describe-stacks \
  --stack-name eks-cluster \
  --query "Stacks[0].Outputs[?OutputKey==`eks-cluster-ClusterName`].OutputValue" \
  --output text'
