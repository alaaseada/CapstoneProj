#! /bin/bash

echo "Hello world, from changeTag"


sed "s/tagname/$1/g" website_deployment.yml > current_deployment.yml
