#!/bin/bash

echo Validating commit against $BITBUCKET_PR_DESTINATION_BRANCH
git fetch origin $BITBUCKET_PR_DESTINATION_BRANCH:$BITBUCKET_PR_DESTINATION_BRANCH

if [[ $BITBUCKET_PR_DESTINATION_BRANCH = master ]]; then
  . scripts/bb-validate-commits.sh
fi

. scripts/bb-validate-changelog.sh

echo Everything seems fine!
