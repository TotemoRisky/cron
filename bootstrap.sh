#!/usr/bin/env bash

date

USER="onoie"
ORG_NAME=$USER
REPO_NAME="status"
TOKEN=$GITHUB_TOKEN_CRON
MODE="CRON"
if [ $# = 1 ]; then
   MODE=$1
fi
echo MODE:$MODE


#clone
rm -rf $REPO_NAME
echo "try clone"
git clone https://${USER}:${TOKEN}@github.com/${ORG_NAME}/${REPO_NAME} > /dev/null 2>&1
if [[ -d $REPO_NAME ]] ; then
	mv main.go $REPO_NAME/
	cd $REPO_NAME
	go run main.go
else
	echo "clone error"
	exit
fi


#update
bash -c "cat << 'EOF' > ok
$(date +%Y%m%d%H%M%S)
EOF"

NOW=$(TZ=Asia/Tokyo date +%Y%m%d%H%M%S)
cat << EOF > latest.json
{"latest":"$NOW"}
EOF


#commit
git config --local user.name "TotemoRisky"
git config --local user.email "risky.totemo@gmail.com"
#git checkout --orphan tmp
git add .
git commit --allow-empty -m "${MODE}_$NOW"
#git checkout -B master
#git branch -d tmp
echo "try push"
git push -f --set-upstream origin master > /dev/null 2>&1


echo "complete"

