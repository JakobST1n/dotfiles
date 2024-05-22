#!/bin/bash

echo "[$(date)] Running cleaning routine"
set -o pipefail
set -x

max_age_days=5
find "DT_HOME_DIRECTORY/Downloads/" -mtime +${max_age_days} -delete
