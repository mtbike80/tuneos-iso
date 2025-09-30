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
#   3. Build the ISO and save with a date-based filename                       #
#                                                                              #
################################################################################

set -e  ## This tell bash that, if any command exits with a non-zero status,
        ## immediately stop running the script.

ISO_NAME="tuneos-$(date+%Y%m%d).iso"

echo "[   ] Cleaning old build artifacts..."
sudo lb clean --purge                       ## Thie removes all build artifacts
                                            ## from previous runs.
echo "[ * ] Cleaning old build artifacts..."


## Configure the live build ##

echo "[   ] Configuring live-build..."

## Set up build parameters
sudo lb config \
  --distrubtion trixie \
  --debian-installer netinst \
  --archive-areas "main contrib non-free-firmware"

echo "[ * ] Configuring live-build..."


## Build the ISO ##

echo "[   ] Building ISO. This may take a while..."
sudo lb build
echo "[ * ] Building ISO. This may take a while..."


## Rename the ISO ##

## By default, the live-build output file is named "binary.hybrid.iso".
## If the build succeeds, rename it. Else, throw an error and exit.

if [ -f binary.hybrid.iso ]; then
  mv binary.hybrid.iso "$ISO_NAME"
  echo "[ * ] Build complete: $ISO_NAME"
else
  echo "[ ! ] Build failed: ISO not found."
  exit 1
fi
