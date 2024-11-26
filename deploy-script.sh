#!/bin/bash
set -e

current_date=$(date +%Y%m%d)
commit_message="deployment_${current_date}"

npm run build
cd dist

git add -A
git commit -m "${commit_message}"
git push origin master:gh-pages
