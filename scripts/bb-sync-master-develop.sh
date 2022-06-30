#!/bin/bash

curl -v https://api.bitbucket.org/2.0/repositories/$BITBUCKET_REPO_OWNER/$BITBUCKET_REPO_SLUG/pullrequests \
  -u $BB_TOKEN_BASIC_AUTH \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "title": "Syncing master > develop",
    "destination": {
      "branch": {
        "name": "develop"
      }
    },
    "source": {
      "branch": {
        "name": "master"
      }
    }
  }'
