#! /bin/bash

git stage .
git commit -m "Update the eb application to version 3"
git checkout development
git pull . master
git checkout production
git pull . master
git checkout master
git push --all
