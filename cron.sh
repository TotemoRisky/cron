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
else
    echo "clone error"
    exit
fi

#config
git config --local user.name $GIT_NAME
git config --local user.email $GIT_EMAIL



go run main.go

bash -c "cat << 'EOF' > ok
$(date +%Y%m%d%H%M%S)
EOF"

NOW=$(TZ=Asia/Tokyo date +%Y%m%d%H%M%S)
cat << EOF > latest.json
{"latest":"$NOW"}
EOF



#commit
#git checkout --orphan tmp
git add .
git commit --allow-empty -m "CRON_$NOW"
#git checkout -B master
#git branch -d tmp
echo "try push"
git push -f --set-upstream origin master > /dev/null 2>&1

#cleanup
rm -rf $REPO_NAME
