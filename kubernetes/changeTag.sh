!# /bin/bash

sed "s/tagname/$1/g" website_deployment.yaml > current_deployment.yaml
