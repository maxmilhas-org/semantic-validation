CHANGELOG=$(if [[ $(git diff $BITBUCKET_PR_DESTINATION_BRANCH.. --stat | grep -E 'CHANGELOG.+\|') = '' ]]; then echo 0; else echo 1; fi)

if [[ $CHANGELOG = '0' ]]; then echo 'No changelog has been changed!'; exit 1; fi

echo Changelog seems fine!
