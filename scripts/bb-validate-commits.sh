#!/bin/bash
REGEX=$(node scripts/get-changelog-release-regex.js)
COMMITS=$(if [[ $(git shortlog $BITBUCKET_PR_DESTINATION_BRANCH.. | grep -P $REGEX) = '' ]]; then echo 0; else echo 1; fi)

if [[ $COMMITS = '0' ]]; then echo 'No changes were found!'; exit 1; fi

echo Commits seems fine!
