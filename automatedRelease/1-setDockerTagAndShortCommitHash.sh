#!/bin/bash
echo "Build branch: %teamcity.build.branch%"
buildBranch=%teamcity.build.branch% &&
shortCommitHash=$(echo %build.vcs.number% | head -c7)

if [[ $(echo $(echo $buildBranch) | rev | cut -d/ -f1 | rev) = "head" ]]
then
  buildBranch=pr$(echo $(echo $buildBranch) | rev | cut -d/ -f2 | rev)
else
  buildBranch=$(echo $(echo $buildBranch) | rev | cut -d/ -f1 | rev)
fi

echo "DOCKER TAG: $buildBranch"
echo "SHORT COMMIT HASH: $shortCommitHash"

echo "##teamcity[setParameter name='env.DOCKER_TAG' value='$buildBranch']"
echo "##teamcity[setParameter name='env.SHORT_COMMIT_HASH' value='$shortCommitHash']"
echo "##teamcity[buildNumber '%build.number% | $buildBranch']"
