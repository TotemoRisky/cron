#!/usr/bin/env bash

date

USER="onoie"
ORG_NAME=$USER
REPO_NAME="status"
GIT_NAME="TotemoRisky"
GIT_EMAIL="risky.totemo@gmail.com"
TOKEN=$GITHUB_TOKEN_CRON

#clone
rm -rf $REPO_NAME
echo "try clone"
git clone https://${USER}:${TOKEN}@github.com/${ORG_NAME}/${REPO_NAME} > /dev/null 2>&1
if [[ -d $REPO_NAME ]] ; then
    cd $REPO_NAME
    git config --local user.name $GIT_NAME
    git config --local user.email $GIT_EMAIL
else
    echo "clone error"
    exit
fi

echo "complete"

