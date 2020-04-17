#! /bin/bash

git stage .
git commit -m "Specify the cluster version to 1.15.11"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
