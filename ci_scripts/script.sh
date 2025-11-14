#!/bin/sh

set -e

OSV_BIN="./bin/osv-scanner"
OSV_URL="https://github.com/google/osv-scanner/releases/latest/download/osv-scanner_darwin_arm64"
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"


echo "Checking if OSV Scanner installed"

if [ ! -f "$OSV_BIN" ]; then
  echo "OSV Scanner not found"
  download_osv
else
  echo "OSV Scanner found at $OSV_BIN" 
fi

echo "Running vulnerability scan"
"$OSV_BIN" --lockfile="$PROJECT_ROOT/pubspec.lock"


download_osv() {
  echo "Downloading OSV Scanner..."
  if ! curl -fL "$OSV_URL" -o osv-scanner; then
    echo "Error: Failed to download OSV Scanner from $OSV_URL" >&2
    exit 1
  fi

  chmod +x osv-scanner
  mkdir -p ./bin
  mv osv-scanner "$OSV_BIN"
  echo "OSV Scanner installed at $OSV_BIN"
}