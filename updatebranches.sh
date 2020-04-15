#! /bin/bash

git stage .
git commit -m "Update"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
