#! /bin/bash
function is_deployment_exists() {
	for deployment in $(kubectl get deployments | awk 'NR>1{print $1}'); do
	if [[ "$deployment" == "website-deployment" ]]; then
		return 0  # then return True
	fi
	done
	return 1  # then return False
}

if [ is_deployment_exists ]
then
	kubectl set image deployment/website-deployment  mywebsite=aseada/asblog_repo:$1 --record
	kubectl rollout status deployment.v1.apps/website-deployment
	kubectl rollout history deployment.v1.apps/website-deployment
else
	kubectl apply -f current_deployment.yaml
fi

kubectl get svc

