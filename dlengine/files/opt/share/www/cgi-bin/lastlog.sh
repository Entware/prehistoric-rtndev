#!/opt/bin/bash

. /opt/etc/dlengine.conf

echo "Content-type: text/html"
echo
echo "<html><head>"
echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
echo "<meta http-equiv=\"Pragma\" content=\"no-cache\">"
echo "<meta http-equiv=\"Cache-Control\" content=\"no-cache\">"
echo "<title></title></head><body>"
echo "<pre>"
tail -n10 $LOGFILE
echo "</pre>"
echo "</body></html>"
