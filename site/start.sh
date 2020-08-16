#!/usr/bin/env bash

export TOR_SITE_DIR="${TOR_SITE_DIR:-/usr/local/share/tor}"
export TOR_PUBLIC_DIR="${TOR_PUBLIC_DIR:-TOR_SITE_DIR/public}"

lite-server -c "$TOR_SITE_DIR/bs-config.json" || \
python3 -m http.server --cgi --directory "$TOR_PUBLIC_DIR" 8082 || \
python2 -m http.server --cgi --directory "$TOR_PUBLIC_DIR" 8082 || \
echo "Failed to start the tor site server"
