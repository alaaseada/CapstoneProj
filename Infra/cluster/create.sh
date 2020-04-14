#! /bin/bash
aws cloudformation create-stack --stack-name "eks-cluster" --template-body file://clusterinfra.yml --parameters file://clusterinfra-params.json --capabilities CAPABILITY_NAMED_IAM --region=us-west-2