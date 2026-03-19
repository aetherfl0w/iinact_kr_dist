#!/bin/sh
set -e

ZIPFILE=$(ls /data/FFXIV_ACT_Plugin_*.zip 2>/dev/null | head -1)

if [ -z "$ZIPFILE" ]; then
  echo "no FFXIV_ACT_Plugin_*.zip found in /data"
  exit 1
fi

FNAME=$(basename "$ZIPFILE")
VERSION=$(echo "$FNAME" | sed 's/FFXIV_ACT_Plugin_//;s/\.zip//')

cat > /etc/nginx/conf.d/default.conf <<EOF
server {
    listen 80;

    location = /version {
        default_type text/plain;
        return 200 '$VERSION\n';
    }

    location = /download {
        alias $ZIPFILE;
        add_header Content-Disposition 'attachment; filename="$FNAME"';
    }
}
EOF

echo "serving $FNAME (version: $VERSION)"
exec nginx -g 'daemon off;'
