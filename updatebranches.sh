#! /bin/bash

git stage .
git commit -m "Update cluster create shell script"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
