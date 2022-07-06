#!/bin/bash

echo '{"user":"'$(echo $BB_TOKEN_BASIC_AUTH | sed -rn 's/:.+//p')'","password":"'$(echo $BB_TOKEN_BASIC_AUTH | sed -rn 's/.+://p')'","workspace":"'$BITBUCKET_REPO_OWNER'"}' > bitbucket-ext.json
COMMIT_PATTERN=$(npx bitbucket-ext get-project-info $BITBUCKET_REPO_SLUG | jq .description | sed -rn 's/COMMIT_PATTERN: (.+)/\1/p' | sed -e 's/^"//' -e 's/"$//' || echo)
if [[ $COMMIT_PATTERN = '' ]]; then
  COMMIT_PATTERN='(fix|feat|perf|revert):'
fi
rm -rf bitbucket-ext.json
COMMITS=$(if [[ $(git log $BITBUCKET_PR_DESTINATION_BRANCH.. | grep -E $COMMIT_PATTERN) = '' ]]; then echo 0; else echo 1; fi)

if [[ $COMMITS = '0' ]]; then echo 'No changes were found! Pattern '$COMMIT_PATTERN; exit 1; fi
