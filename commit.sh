#!/usr/bin/env bash
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
