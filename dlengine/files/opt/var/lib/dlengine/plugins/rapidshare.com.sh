# plugin: get direct link from http://rapidshare.com
# by Serg0 [27.02.2010]

TEMP_HTML="${TEMPDIR}dlengine.temp.html"

get_login_password "rapidshare.com"  # получим логин/пароль

while true ; do

  if [ -n "$password" ]; then break; fi  # если есть пароль

  log "-- Step.1:"
  # скачаем первую страницу
  $WGETBIN "$1" -O "$TEMP_HTML" --quiet

  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # "The file could not be found.  Please check the download link."
  if grep -iq "The file could not be found.*Please check the download link" "$TEMP_HTML" ; then
    log "FAILED: The file could not be found. Please check the download link."
    return $RC_FAIL
  fi

  # "This file is neither allocated to a Premium Account, or a Collector's Account, and can therefore only be downloaded 10 times."
  if grep -iq "This file .* can therefore only be downloaded 10 times" "$TEMP_HTML" ; then
    log "FAILED: limit reached - this file can only be downloaded 10 times"
    return $RC_FAIL
  fi

  # "The server 57.rapidshare.com is momentarily not available."
  if grep -iq "The server .* is momentarily not available" "$TEMP_HTML" ; then
    log "waiting 1 min : The server XX.rapidshare.com is momentarily not available"
    sleep 60  # подождем 1 минуту
    continue  # и попробуем снова
  fi

  # <input type="submit" value="Free user" />
  if ! grep -iq "input.*submit.*Free user" "$TEMP_HTML" ; then
    log "FAILED: Button [Free user] not found"
    return $RC_FAIL
  fi

  # поищем url2
  # <form id="ff" action="http://rs300.rapidshare.com/files/100443451/King.Kong.part01.rar" method="post">
  url=$( sed -n 's/^.*<form.* action="\([^\"]*\)".*$/\1/p' "$TEMP_HTML" | head -n1 )
  # url2 не нашли?
  if [ "$url" = "" ] ; then log "FAILED: URL2 not found"; return $RC_FAIL; fi

  log "url2=$url"

  log "-- Step.2:"
  # скачаем вторую страницу
  $WGETBIN "$url" -O "$TEMP_HTML" --post-data="dl.start=Free" --quiet

  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # "Your IP address XX.XX.XX.XX is already downloading a file.  Please wait until the download is completed."
  if grep -iq "Your IP address .* is already downloading a file" "$TEMP_HTML" ; then
    log "waiting 5 min : Your IP address is already downloading a file"
    sleep 300 # подождем 5 минут
    continue  # и попробуем снова
  fi

  # "no more download slots left for non-members. Of course you can also try again later."
  if grep -iq "no more download slots left for non-members" "$TEMP_HTML" ; then
    log "waiting 2 min : No slots for free users, try again later"
    sleep 120 # подождем 2 минуты
    continue  # и попробуем снова
  fi

  # "Currently a lot of users are downloading files.  Please try again in 2 minutes"
  if grep -iq "lot of users are downloading files" "$TEMP_HTML" ; then
    log "waiting 2 min : lot of users are downloading files, try again in 2 minutes"
    sleep 120 # подождем 2 минуты
    continue  # и попробуем снова
  fi

  # "You have reached the download limit for free-users"
  # "Or try again in about XX minutes"
  wait=$( sed -n 's/^.*Or try again in about \([0-9]*\) minutes.*$/\1/p' "$TEMP_HTML" )
  if [ "$wait" != "" ] ; then
    log "waiting $wait min : reached the download limit, try again in about $wait minutes"
    sleep $(($wait*60))  # подождем XX минут
    continue             # и попробуем снова
  fi

  # поищем url3
  # <form name="dlf" action="http://rs300tl3.rapidshare.com/files/100443451/2125510/King.Kong.part01.rar" method="post">
  url=$( sed -n 's/^.*<form.* action="\([^\"]*\)".*$/\1/p' "$TEMP_HTML" )
  # url3 не нашли?
  if [ "$url" = "" ] ; then log "FAILED: URL3 not found"; return $RC_FAIL; fi

  # "Still XX seconds"
  # "var c=XX;"
  wait=$( sed -n 's/^.*var c=\([0-9]*\);.*$/\1/p' "$TEMP_HTML")
  # wait не нашли?
  if [ "$wait" = "" ] ; then log "FAILED: var c=XX (Still XX seconds) - not found"; return $RC_FAIL; fi

  log "waiting $wait sec : Still $wait seconds"
  sleep $wait  # ждем XX секунд

  DLE_LINK=$url
  return $RC_OK

done # while


# ----------------------------------------------------------
# режим - с использованием пароля:

log "mode - premium user"

cookies="$TEMP_HTML.cookies"  # имя cookies-файла

# получим cookies
$WGETBIN "http://rapidshare.com/cgi-bin/premium.cgi" -O "$TEMP_HTML" --post-data="premiumlogin=1&accountid=${login}&password=${password}" --save-cookies="$cookies" --quiet
error=$?  # wget.error ?
if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

# "Cookie set.  The Account is valid"
if ! grep -iq "Cookie set.* Account is valid" "$TEMP_HTML" ; then
  log "FAILED: Invalid Login/Password"
  return $RC_FAIL
fi

log "cookies set - ok"

# $url = исходнаЯ ссылка
DLE_LINK=$1

return $RC_OK
