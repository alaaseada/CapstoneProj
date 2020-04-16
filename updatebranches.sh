#! /bin/bash

git stage .
git commit -m "Merge service and website_deployment.yaml files"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
