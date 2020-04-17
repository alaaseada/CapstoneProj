#! /bin/bash

git stage .
git commit -m "Update Jenkins file with the full steps"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
