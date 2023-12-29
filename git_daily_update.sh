#!/bin/bash

# Move to the target directory
cd ~/Github/n350071/notes

# Perform git operations
git checkout main
git add .
git commit -m "$(date '+%Y-%m-%d')"
git push origin main


# 権限設定
# chmod +x ~/Github/n350071/notes/git_daily_update.sh

# cron設定
# crontab -e
# 0 12 * * * /bin/bash ~/Github/n350071/notes/git_daily_update.sh


