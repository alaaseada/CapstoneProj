#! /bin/bash

git stage .
git commit -m "Version 2 of my web application"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
