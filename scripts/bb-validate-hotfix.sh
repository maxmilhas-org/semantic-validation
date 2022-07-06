#!/bin/bash

echo Validating commit against $BITBUCKET_PR_DESTINATION_BRANCH
git fetch origin $BITBUCKET_PR_DESTINATION_BRANCH:$BITBUCKET_PR_DESTINATION_BRANCH
. ./scripts/bb-validate-commits.sh

CHANGELOG=$(if [[ $(git diff $BITBUCKET_PR_DESTINATION_BRANCH.. --stat | grep -E 'CHANGELOG.+\|') = '' ]]; then echo 0; else echo 1; fi)

if [[ $CHANGELOG = '0' ]]; then echo 'No changelog has been changed!'; exit 1; fi
