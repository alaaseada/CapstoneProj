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

	aws cloudformation wait stack-create-complete --region us-west-2 --stack-name "eks-cluster" 

	clusterName=$(aws cloudformation describe-stacks \
          --stack-name "eks-cluster" \
          --query "Stacks[0].Outputs[?OutputKey=='ClusterName'].OutputValue" \
          --output text \
          --region=us-west-2)

	echo $clusterName

	sed "s/replaceclustername/$clusterName/g" ../nodes/nodes-params.json > ../nodes/cluster-nodes-params.json

	aws eks update-kubeconfig --name $clusterName --region us-west-2
else
	clusterName=$(aws cloudformation describe-stacks \ 
         		--stack-name "eks-cluster" \
         		--query "Stacks[0].Outputs[?OutputKey=='ClusterName'].OutputValue" \ 
		 	--output text \
		 	--region=us-west-2)
	echo $clusterName
	sed "s/replaceclustername/$clusterName/g" ../nodes/nodes-params.json > ../nodes/cluster-nodes-params.json
	aws eks update-kubeconfig --name $clusterName --region us-west-2
	echo "The stach \"eks-cluster\" is already exists"
fi
