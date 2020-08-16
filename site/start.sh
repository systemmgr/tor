#!/usr/bin/env bash

TOR_SITE_DIR="${TOR_SITE_DIR:-/usr/local/share/tor}"
TOR_PUBLIC_DIR="${TOR_PUBLIC_DIR:-TOR_SITE_DIR/public}"

python2 -m http.server --cgi --directory "$TOR_PUBLIC_DIR" 8082 || \
python3 -m http.server --cgi --directory "$TOR_PUBLIC_DIR" 8082 || \
lite-server -c "$TOR_SITE_DIR/bs-config.json" || \
echo "Failed to start the tor site server"
