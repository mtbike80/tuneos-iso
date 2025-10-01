#!/bin/bash

SEARCH_PATH="/home/tuna/tuneos-build"
EXCLUDE_FILE="live-image-amd64.hybrid.iso"

set -e

## Find and delete files
echo "Deleting files..."
sudo find "$SEARCH_PATH" -type f -user root -group root ! -name "$EXCLUDE_FILE" -exec rm -f {} +

## Find and delete directories
echo "Deleting directories..."
sudo find "$SEARCH_PATH" -depth -type d -user root -group root ! -name "$EXCLUDE_FILE" -exec rm -rf {} +
