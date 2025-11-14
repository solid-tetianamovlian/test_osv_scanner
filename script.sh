#!/bin/sh

set -e

echo "Install OSV scanner"
curl -L https://github.com/google/osv-scanner/releases/latest/download/osv-scanner_darwin_arm64 -o osv-scanner
chmod +x osv-scanner

# Move to a local bin folder
mkdir -p ./bin
mv osv-scanner ./bin/osv-scanner

# Add local bin to PATH
export PATH="$PATH:$(pwd)/bin"

echo "Run vulnerability scan"
osv-scanner --lockfile=pubspec.lock

echo "Success"
