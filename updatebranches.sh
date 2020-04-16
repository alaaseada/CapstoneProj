#! /bin/bash

git stage .
git commit -m "Change apiVersion"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
