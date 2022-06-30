#!/bin/bash

apt-get update && apt-get install -y curl jq
git remote set-url origin "https://${BB_TOKEN_BASIC_AUTH}@bitbucket.org/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}"
npm i -g @semantic-release/changelog @semantic-release/commit-analyzer @semantic-release/git @semantic-release/exec @semantic-release/npm @semantic-release/release-notes-generator semantic-release
semantic-release --ci
git pull
git push
git push origin --tags
git checkout develop
git pull
(git merge master && git push) || ssh bb-sync-master-develop.sh
