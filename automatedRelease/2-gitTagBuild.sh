#!/bin/bash
git status

git reset --hard

if echo $(git log -1 --pretty=%B) | tr '[:upper:]' '[:lower:]' | grep major
then
  echo Major version build &&
  npm version major || { echo 'npm version major failed' ; exit 1; }
elif echo $(git log -1 --pretty=%B) | tr '[:upper:]' '[:lower:]' | grep minor
then
  echo Minor version build &&
  npm version minor || { echo 'npm version minor failed' ; exit 1; }
else
  echo Patch version &&
  npm version patch || { echo 'npm version patch failed' ; exit 1; }
fi

git status

echo $(git log -1 --pretty=%B)

git push &&
git push --tags &&
echo "##teamcity[setParameter name='env.DOCKER_TAG' value='$(git log -1 --pretty=%B)']" &&
echo "##teamcity[buildNumber '%build.number% | $(git log -1 --pretty=%B)']"
