#!/bin/sh
set -e
m4_ifelse(DT_GOTIFY_URL, `', `', `m4_dnl
GOTIFY_URL="DT_GOTIFY_URL/message?token=DT_GOTIFY_TOKEN"
')m4_dnl
MESSAGE="Done"
if [ "$#" = "1" ]; then
    MESSAGE="$1"
fi

tput bel
tmux display-message "${MESSAGE}"
m4_ifelse(DT_GOTIFY_URL, `', `', `m4_dnl
GOTIFY_RES=$(curl "$GOTIFY_URL" -F "title=Pingme" -F "message=$MESSAGE" -F "priority=5" 2> /dev/null)
')m4_dnl
