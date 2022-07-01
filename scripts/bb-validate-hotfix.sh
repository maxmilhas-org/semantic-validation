#!/bin/bash
echo Validating commit against $BITBUCKET_PR_DESTINATION_BRANCH
git fetch origin $BITBUCKET_PR_DESTINATION_BRANCH:$BITBUCKET_PR_DESTINATION_BRANCH || echo could not fetch origin. Trying it anyway
. scripts/bb-validate-commits.sh
. scripts/bb-validate-changelog.sh

echo Everything seems fine!
