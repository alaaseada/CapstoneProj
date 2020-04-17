#! /bin/bash

git stage .
git commit -m "Fix Dockerfile to fix the error in lint"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
