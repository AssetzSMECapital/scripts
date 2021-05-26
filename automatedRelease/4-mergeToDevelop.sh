#!/bin/bash
git fetch origin develop:develop &&
git checkout develop &&
git merge master &&
git push origin develop
