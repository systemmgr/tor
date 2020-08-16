#!/usr/bin/env bash

export TOR_SITE_DIR="${TOR_SITE_DIR:-/usr/local/share/tor}"
export TOR_PUBLIC_DIR="${TOR_PUBLIC_DIR:-$TOR_SITE_DIR/public}"

python3 -m http.server --cgi --bind 127.0.0.1 8082 || \
python2 -m http.server --cgi --bind 127.0.0.1 8082 || \
python -m SimpleHTTPServer 8082 || \
echo "Failed to start the tor site server" 
