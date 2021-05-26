#!/bin/bash
UPDATE_PR_TEXT='N'
if git log -1 --skip 1--pretty=%B | grep "Merge pull request #[[:digit:]][[:digit:]]* from AssetzSMECapital/develop"
then
    UPDATE_PR_TEXT='Y'
fi

PR_NUMBER=$(git log -1 --skip 1--pretty=%B | grep "Merge pull request #[[:digit:]][[:digit:]]* from AssetzSMECapital/develop" | cut -d '#' -f 2 | cut -d ' ' -f 1) &&
REPO=$(echo %vcsroot.url% | cut -d '/' -f 2 | cut -d '.' -f 1) &&
VERSION=$(git log -1 --pretty=%B) &&
echo "$PR_NUMBER - $REPO - $VERSION - $UPDATE_PR_TEXT" &&
curl -X POST %teamcity.serverUrl%/app/rest/buildQueue \
  -H "Authorization: Bearer %tcToken%" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
  "buildType": {
    "id": "Utilities_GenerateRelease"
  },
  "properties": {
    "property": [
      { "name": "Repo", "value": "'"$REPO"'" },
      { "name": "Version", "value": "'"$VERSION"'" },
      { "name": "PrNumber", "value": "'"$PR_NUMBER"'" },
      { "name": "DryRun", "value": "N" },
      { "name": "CreateRelease", "value": "Y" },
      { "name": "PostToSlack", "value": "Y" },
      { "name": "UpdatePrText", "value": "'"$UPDATE_PR_TEXT"'" }
    ]
  }
}'
