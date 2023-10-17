#!/bin/bash

echo Validating commit against $BITBUCKET_PR_DESTINATION_BRANCH
git fetch origin $BITBUCKET_PR_DESTINATION_BRANCH:$BITBUCKET_PR_DESTINATION_BRANCH
COMMITS=$(if [[ $(git log $BITBUCKET_PR_DESTINATION_BRANCH.. | grep -E '(fix|feat|perf|revert)(\([a-zA-Z0-9\-_\s]+\))?:') = '' ]]; then echo 0; else echo 1; fi)

if [[ $COMMITS = '0' ]]; then echo 'No changes were found!'; exit 1; fi

CHANGELOG=$(if [[ $(git diff $BITBUCKET_PR_DESTINATION_BRANCH.. --stat | grep -E 'CHANGELOG.+\|') = '' ]]; then echo 0; else echo 1; fi)

if [[ $CHANGELOG = '0' ]]; then echo 'No changelog has been changed!'; exit 1; fi
