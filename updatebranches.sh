#! /bin/bash

git stage .
git commit -m "Update Jenkinsfile, add deploy shell script to allow annotation to deployments"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
