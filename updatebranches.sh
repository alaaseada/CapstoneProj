#! /bin/bash

git stage .
git commit -m "Merge deployment and service yaml files"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
