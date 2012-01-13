#!/opt/bin/bash
# Download Engine Web Interface

. /opt/var/lib/dlengine/utils

echo "Content-type: text/html"
echo
echo "<html><head>"
echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
echo "<meta http-equiv=\"Pragma\" content=\"no-cache\">"
echo "<meta http-equiv=\"Refresh\" content=\"300\">"
echo "<title>Download Engine</title>"
echo "</head>"
echo "<script type='text/javascript' language='javascript'>"
echo "        function makeRequest(url, element_id) {"
echo "                var http_request = false;"
echo "                if (window.XMLHttpRequest) { // Mozilla, Safari, ..."
echo "                        http_request = new XMLHttpRequest();"
echo "                        if (http_request.overrideMimeType) {"
echo "                                http_request.overrideMimeType('text/xml');"
echo "                        }"
echo "                } else if (window.ActiveXObject) { // IE"
echo "                        try {"
echo "                                http_request = new ActiveXObject(\"Msxml2.XMLHTTP\");"
echo "                        } catch (e) {"
echo "                                try {"
echo "                                        http_request = new ActiveXObject(\"Microsoft.XMLHTTP\");"
echo "                                } catch (e) {}"
echo "                        }"
echo "                }"
echo "                if (!http_request) {"
echo "                        alert('errorXMLHTTP');"
echo "                        return false;"
echo "                }"
echo "                http_request.onreadystatechange = function() { updateContents(http_request, element_id); };"
echo "                url = url + \"?ts=\" + new Date().getTime();"
echo "                if (element_id == 'sp_fname') {"
echo "                        url = url + \"&addurl=\"+document.urlform.addurl.value "
echo "                }"
echo "                http_request.open('get', url, true);"
echo "                http_request.send(null);"
echo "        }"
echo "        function updateContents(http_request, element_id) {"
echo "                if (http_request.readyState == 4) {"
echo "                        if (http_request.status == 200) {"
echo "                                document.getElementById(element_id).innerHTML = http_request.responseText;"
echo "                        } else {"
echo "                                alert('request trouble.');"
echo "                        }"
echo "                }"
echo "        }"
echo "</script>"
echo "<body>"
echo "<h2>Download Engine Status Page</h2><hr>"

# Read the queue

declare -a queue
readqueue

# Processing the command

cat >/tmp/post
post="`cat /tmp/post`"
echo "$post" >>/tmp/post.log
if [ "$post" = "daemon=Start" ] && ! daemonrunning; then
   $DAEMON &
   sleep 3
elif [ "$post" = "daemon=ScanFTP" ]; then
   cd $BASEDIR
   rm .listing .listing2 2>/dev/null
   /opt/bin/wget --no-remove-listing -O /dev/null ftp://$PVTUSER:$PVTPASS@$PVTFTP/ >/dev/null 2>/dev/null
   cat .listing | awk '{print substr($0, index($0,":")+4)}' | tr -d "\r" >.listing2
   while read line; do
      if [ -n "`grep -F \"$PVTFTP/$line\" files.queue`" ]; then
         continue
      fi
      if [ -n "`grep -F \"$PVTFTP/$line\" files.done`" ]; then
         continue
      fi
      if [ "$line" == "files.lst" ] || [ "$line" == "." ] || [ "$line" == ".." ]; then
         continue
      fi
      echo ftp://$PVTFTP/$line >>files.queue
   done <.listing2
   rm .listing .listing2 2>/dev/null
   readqueue
elif [ "$post" = "daemon=Stop" ] && daemonrunning; then
   kill "`cat $MAINPID`" 2>/dev/null
   if [ -e $TASKPID ]; then kill "`cat $TASKPID`" 2>/dev/null; fi
   sleep 3
elif [ -n "`grep /tmp/post -e \"addurl=.*\"`" ]; then
   url=${post##addurl=}
   url=`echo $url | sed -e 's/%3F/?/g' -e 's/%3D/=/g' -e 's/%20/ /g' -e 's/%3A/:/g' -e 's/%7E/~/g' -e 's/+/ /' -e 's/%25/%/g' -e 's/%28/\(/g' -e 's/%29/\)/g' -e 's/%2F/\//g' -e 's/%22/\"/g' -e 's/%D0%90/%C0/g' -e 's/%D0%B0/%E0/g'  -e 's/%D0%91/%C1/g'  -e 's/%D0%B1/%E1/g' -e 's/%D0%92/%C2/g' -e 's/%D0%B2/%E2/g' -e 's/%D0%93/%C3/g' -e 's/%D0%B3/%E3/g' -e 's/%D0%94/%C4/g' -e 's/%D0%B4/%E4/g' -e 's/%D0%95/%C5/g' -e 's/%D0%B5/%E5/g' -e 's/%D0%81/%A8/g' -e 's/%D1%91/%B8/g' -e 's/%D0%96/%C6/g' -e 's/%D0%B6/%E6/g' -e 's/%D0%97/%C7/g' -e 's/%D0%B7/%E7/g' -e 's/%D0%98/%C8/g' -e 's/%D0%B8/%E8/g' -e 's/%D0%99/%C9/g' -e 's/%D0%B9/%E9/g' -e 's/%D0%9A/%CA/g' -e 's/%D0%BA/%EA/g' -e 's/%D0%9B/%CB/g' -e 's/%D0%BB/%EB/g' -e 's/%D0%9C/%CC/g' -e 's/%D0%BC/%EC/g' -e 's/%D0%9D/%CD/g' -e 's/%D0%BD/%ED/g' -e 's/%D0%9E/%CE/g' -e 's/%D0%BE/%EE/g' -e 's/%D0%9F/%CF/g' -e 's/%D0%BF/%EF/g' -e 's/%D0%A0/%D0/g' -e 's/%D1%80/%F0/g' -e 's/%D0%A1/%D1/g' -e 's/%D1%81/%F1/g' -e 's/%D0%A2/%D2/g' -e 's/%D1%82/%F2/g' -e 's/%D0%A3/%D3/g' -e 's/%D1%83/%F3/g' -e 's/%D0%A4/%D4/g' -e 's/%D1%84/%F4/g' -e 's/%D0%A5/%D5/g' -e 's/%D1%85/%F5/g' -e 's/%D0%A6/%D6/g' -e 's/%D1%86/%F6/g' -e 's/%D0%A7/%D7/g' -e 's/%D1%87/%F7/g' -e 's/%D0%A8/%D8/g' -e 's/%D1%88/%F8/g' -e 's/%D0%A9/%D9/g' -e 's/%D1%89/%F9/g' -e 's/%D0%AA/%DA/g' -e 's/%D1%8A/%FA/g' -e 's/%D0%AB/%DB/g' -e 's/%D1%8B/%FB/g' -e 's/%D0%AC/%DC/g' -e 's/%D1%8C/%FC/g' -e 's/%D0%AD/%DD/g' -e 's/%D1%8D/%FD/g' -e 's/%D0%AE/%DE/g' -e 's/%D1%8E/%FE/g' -e 's/%D0%AF/%DF/g' -e 's/%D1%8F/%FF/g'`
   echo "$url" >>$QUEUEFILE
   readqueue
elif [ -n "`grep /tmp/post -e \"qpos=.*&qact=.*\"`" ]; then
   qpos=${post%%&*}
   qpos=${qpos##*=}
   act=${post##*act=}
   let qsize=${#queue[*]}-1
   if [ "$act" = "Up" ] && [ $qpos != 0 ]; then
      swapurls $qpos $qpos-1
      savequeue
   elif [ "$act" = "Down" ] && [ $qpos != $qsize ]; then
      swapurls $qpos $qpos+1
      savequeue
   elif [ "$act" = "Bottom" ] && [ $qpos != $qsize ]; then
      url=${queue[$qpos]}
      deleteurl $qpos
      savequeue
      echo "$url" >>$QUEUEFILE
      readqueue
   elif [ "$act" = "Top" ] && [ $qpos != 0 ]; then
      echo "${queue[$qpos]}" >/tmp/post
      deleteurl $qpos
      savequeue
      cat $QUEUEFILE >>/tmp/post
      mv /tmp/post $QUEUEFILE
      readqueue
   elif [ "$act" = "Delete" ]; then
      deleteurl $qpos
      savequeue
   fi
fi

# Status and buttons

echo "<table><tr><td colspan=3>Daemon is "
if ! daemonrunning; then
   echo "stopped.</td></tr><tr><td>"
   echo "<form method=post action="$CGIENGINENAME"><input type=submit name=daemon value=Start></form>"
else
   echo "running.</td></tr><tr><td>"
   echo "<form method=post action="$CGIENGINENAME"><input type=submit name=daemon value=Stop></form>"
fi
echo "</td><td><form method=post action="$CGIENGINENAME"><input type=submit name=daemon value=Reload></form>"
echo "</td><td><form method=post action="$CGIENGINENAME"><input type=submit name=daemon value=ScanFTP></form>"
echo "</td></tr></table><hr>"

# Free space

echo "HDD: `df -h $BASEDIR | awk 'NR==3 {print $2" used, "$3" free"}'`"
echo "<hr>"

# Downloads

echo "<table><tr><td><b>Download Queue:</b></td></tr>"
echo "<tr><td><form method=post action="$CGIENGINENAME">"
echo "<select name=qpos size=10 width='100%' STYLE='width: 100%'>"
for ((i=0; i<${#queue[*]}; i++)); do
   echo "<option value=$i>${queue[$i]}</option>"
done
echo "</select><br>"
echo "<input type=submit name=qact value=Delete>"
echo "<input type=submit name=qact value=Top>"
echo "<input type=submit name=qact value=Bottom>"
echo "<input type=submit name=qact value=Up>"
echo "<input type=submit name=qact value=Down>"
echo "</form></td></tr><tr><td><form name='urlform' id='urlform' method=post action="$CGIENGINENAME">"
echo "URL:"
echo "<input type=text name=addurl size=60>"
echo "<a href=\"javascript:makeRequest('getfilename.sh', 'sp_fname')\">to file:</a>"
echo "<span name='sp_fname' id='sp_fname'>"
echo "<input type=text name=loc_fname size=25>"
echo "</span>"
echo "<input type=submit value=Add>"
echo "</form></td></tr></table><hr>"


echo "<table>"
echo "<tr><td><b>Last completed:</b></td></tr>"
echo "<tr><td>"
echo "<span name='sp_comp' id='sp_comp'>"
echo "<pre>"
tail -n10 $DONEFILE
echo "</pre>"
echo "</span>"
echo "</td></tr>"
echo "</table><hr>"
echo "<table>"
echo "<tr><td><b>Last Uncompleted:</b></td></tr>"
echo "<tr><td>"
echo "<span name='sp_uncomp' id='sp_uncomp'>"
echo "<pre>"
tail -n10 $ERRFILE
echo "</pre>"
echo "</span>"
echo "</td></tr>"
echo "</table><hr>"

# Log

echo "<table><tr><td><b>Last log events:</b>"
echo "<a href=\"javascript:makeRequest('lastlog.sh', 'sp_log')\">(Refresh)</a>"
echo "</span>"
echo "</td></tr>"
echo "<tr><td>"
echo "<span name='sp_log' id='sp_log'>"
echo "<pre>"
tail -n10 $LOGFILE
echo "</pre>"
echo "</span>"
echo "</td></tr></table><hr>"

# That's all

echo "</body>"
echo "</html>"
