#!/bin/sh
# Copies the web app from the repo root into the iOS bundle folder (ios/www).
# Runs automatically before every Xcode build; you can also run it by hand.
set -e
cd "$(dirname "$0")"
mkdir -p www
cp ../index.html ../icon.svg www/
echo "Synced web app into ios/www"
