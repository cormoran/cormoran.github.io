#!/bin/sh
cd $(dirname $0)
ROOT_DIR=$(pwd)
# If a command fails then the deploy stops
set -e

printf "\033[0;32mFetching latest release from GitHub...\033[0m\n"
cd public && git fetch origin && git reset --hard origin/release
cd $ROOT_DIR
# Build the project.
printf "\033[0;32mBuilding hugo website...\033[0m\n"
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

cd public
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$* ($(date))"
fi
printf "\033[0;32mCommiting changes to git...\033[0m\n"
git commit -m "$msg"

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"
git push origin release
