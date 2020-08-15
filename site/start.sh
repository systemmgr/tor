#!/usr/bin/env sh

TOR_PUBLIC_DIR="${TOR_PUBLIC_DIR:-/usr/local/share/tor/public}"

python2 -m http.server --cgi --directory "$TOR_PUBLIC_DIR" 8082 || python3 -m http.server --cgi --directory "$TOR_PUBLIC_DIR" 8082
