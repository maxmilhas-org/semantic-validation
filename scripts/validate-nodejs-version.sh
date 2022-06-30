#!/bin/bash

apt-get update && apt-get install -y jq
packageVersion=$(jq -r .version package.json)
VERSIONversion=$(cat VERSION)
echo package.json version = $packageVersion
echo VERSION content = $VERSIONversion

if [[ $packageVersion != $VERSIONversion ]]; then echo Conflicting versions between package.json and VERSION; exit 1; fi
