#! /bin/bash

git stage .
git commit -m "miss with Dockerfile to generate error in lint"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
