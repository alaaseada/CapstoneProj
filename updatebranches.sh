#! /bin/bash

git stage .
git commit -m $1
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
