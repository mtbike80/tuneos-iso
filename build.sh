#!/bin/bash

################################################################################
# build.sh                                                                     #
# --------                                                                     #
#                                                                              #
# Builds TuneOS ISO with live-build                                            #
#                                                                              #
#                                                                              #
# This script automates the steps to:                                          #
#   1. Clean old build artifacts                                               #
#   2. Configure live-build for Debian 13 (Trixie)                             #
#   3. Build the ISO                                                           #
#                                                                              #
################################################################################

set -euo pipefail

echo "Cleaning old build artifacts..."
sudo lb clean || true
echo "Cleaning old build artifacts...DONE"


## Configure the live build for installer-only ISO  ##

echo "Configuring live-build..."

## Set up build parameters
sudo lb config \
  --distribution trixie \
  --debian-installer netinst \
  --binary-images iso-hybrid \
  --archive-areas "main contrib non-free-firmware" \
  --bootappend-live "quiet splash"

echo "Configuring live-build...DONE"


## Build the ISO ##

echo "Building ISO. This may take a while..."
sudo lb build
echo "Building ISO. This may take a while...DONE"


read -p "Run build cleanup? [y/N]: " response

if [[ "$response" == "y" || "$response" == "Y" ]]; then
  ./build_cleanup.sh
fi
