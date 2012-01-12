# plugin: get direct link from http://hotfile.com
# by Serg0 [16.09.2009]

TEMP_HTML="${TEMPDIR}dlengine.temp.html"

while true ; do

  log "-- Step.1:"
  # скачаем первую страницу
  rm $TEMP_HTML 2>/dev/null
  $WGETBIN "$1?lang=en" -O "$TEMP_HTML" --quiet

  error=$?  # wget.error ?
  if [ "$error" != "0" ] ;  then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # ответ пустой или "404 - Not Found"
  if { [ ! -s "$TEMP_HTML" ] || grep -iq "404 - Not Found" "$TEMP_HTML" ;} ; then
    log "FAILED: file not found"
    return $RC_FAIL
  fi

  # "You are currently downloading.."
  if grep -iq "You are currently downloading" "$TEMP_HTML" ; then
    log "waiting 5 min : Your IP address is already downloading a file"
    sleep 5m  # подождем 5 минут
    continue  # и попробуем снова
  fi

  # "You reached your hourly traffic limit."
  # function starthtimer(){ ... timerend=d.getTime()+809000;
  # <script language=JavaScript>starthtimer()</script>
  if grep -iq "script.*starthtimer()./script" "$TEMP_HTML" ; then
    # поищем времЯ ожиданиЯ
    wait=$( sed -n 's/^.*timerend=d.getTime()+\([0-9]*\);.*$/\1/p' "$TEMP_HTML" | tail -n1 )
    # wait="" ?
    if [ "$wait" = "" ] ;  then log "FAILED: hourly wait timer - not found"; return $RC_FAIL; fi
    wait=$( expr $wait / 1000 )  # msec -> sec
    #
    log "waiting ${wait} sec : reached your hourly traffic limit, wait download for $( expr $wait / 60 ) minutes"
    sleep ${wait}s  # подождем XX секунд
    continue        # и попробуем снова
  fi

  # поищем url2
  # <form style="margin:0;padding:0;" action="/dl/294590/a6a11d8/2.zip.html" method=post name=f>
  url=$( sed -n 's/^.*form .* action="\([^"]*\)".*name=f.*$/\1/p' "$TEMP_HTML" )
  # url2 не нашли?
  if [ "$url" = "" ] ;  then log "FAILED: URL2 not found"; return $RC_FAIL; fi

  url="http://hotfile.com${url}"

  # <input type=hidden name=tm value=1240539275>
  tm=$( sed -n 's/^.*input .*name=tm value=\([0-9]*\).*$/\1/p' "$TEMP_HTML" )
  # <input type=hidden name=tmhash value=6222b3c828d2de5b9a55fb599ea871bcf34f34bf>
  tmhash=$( sed -n 's/^.*input .*name=tmhash value=\([0-9a-zA-Z]*\).*$/\1/p' "$TEMP_HTML" )
  # <input type=hidden name=wait value=60>
  wait=$( sed -n 's/^.*input .*name=wait value=\([0-9]*\).*$/\1/p' "$TEMP_HTML" )
  # <input type=hidden name=waithash value=1a5e2574761592c23e07e9ec10666bd5371372b2>
  waithash=$( sed -n 's/^.*input .*name=waithash value=\([0-9a-zA-Z]*\).*$/\1/p' "$TEMP_HTML" )
  # tm, tmhash, wait, waithash = "" ?
  if [ "$tm" = ""  -o  "$tmhash" = ""  -o  "$wait" = ""  -o  "$waithash" = "" ] ; then
    log "FAILED: tm/tmhash/wait/waithash - not found"
    return $RC_FAIL
  fi

  log "url2=$url"

  log "-- Step.2:"

  log "waiting ${wait} sec : Please wait ${wait} seconds"
  sleep ${wait}s  # ждем XX секунд

  # скачаем вторую страницу
  $WGETBIN "$url" -O "$TEMP_HTML" --post-data="action=capt&tm=${tm}&tmhash=${tmhash}&wait=${wait}&waithash=${waithash}" --quiet

  error=$?  # wget.error ?
  if [ "$error" != "0" ] ;  then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # <input type="hidden" name="action" value="checkcaptcha" />
  if grep -iq "checkcaptcha" "$TEMP_HTML" ; then
    log "FAILED: required CAPTCHA"  # требует ввод символов с картинки (CAPTCHA)
    return $RC_FAIL
  fi

  # поищем url3
  # <a href="http://hotfile.com/get/294590/4a7c29b9/36c3992/2.zip">Click here to download</a></h3>
  url=$( sed -n 's/^.*href="\([^"]*\)".Click here to download.*$/\1/p' "$TEMP_HTML" )
  # url3 не нашли?
  if [ "$url" = "" ] ;  then log "FAILED: URL3 not found"; return $RC_FAIL; fi

  DLE_LINK="$url"
  return $RC_OK

done # while
