# plugin: get direct link from http://depositfiles.com
# by Serg0 [30.03.2010]
#
# ѕ–»ћ≈„јЌ»≈:
# - маленькие файлы (<1ћЅ) обрабатываются за 1 шаг

TEMP_HTML="${TEMPDIR}dlengine.temp.html"

get_login_password "depositfiles.com"  # получим логин/пароль

if [ -z "$password" ]; then
  log "waiting 20 sec"
  sleep 20  # сделаем паузу от предыдущего скачивания с depositfiles.com
fi

while true ; do

  if [ -n "$password" ]; then break; fi  # если есть пароль

  # --------------------------
  log "-- Step.1:"
  # скачаем первую страницу
  $WGETBIN "$1" -O "$TEMP_HTML" --quiet
  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # “акого файла не существует или он был удален из-за нарушения авторских прав.
  # <span class="html_download_api-not_exists"></span>
  if grep -iq "html_download_api-not_exists" "$TEMP_HTML" ; then
    log "FAILED: the file not exists"
    return $RC_FAIL
  fi

  ## для маленьких файлов <1ћЅ
  # <strong>¬ настоящее время с вашего IP адреса XX.XX.XX.XX<br/> уже идет скачивание.</strong>
  # <a href="http://depositfiles.com/ru/faq.html#simultaneous_downloads_limit">
  # <span class="html_download_api-limit_parallel"></span>
  if grep -iq "html_download_api-limit_parallel" "$TEMP_HTML" ; then
    log "waiting 5 min : Your IP address is already downloading a file"
    sleep 300 # подождем 5 минут
    continue  # и попробуем снова
  fi

  ## для маленьких файлов <1ћЅ
  # ¬Ќ»ћјЌ»≈! ¬ы исчерпали лимит подключений! ѕопробуйте повторить через
  # 7 минут(ы).  /  55 секунд(ы).  /  1 час(ов).
  # <a href="http://depositfiles.com/ru/faq.html#after_download_limit">
  # <span class="html_download_api-limit_interval">453</span>
  wait=$( sed -n 's/^.*html_download_api-limit_interval.>\([0-9]*\)<.*$/\1/p' "$TEMP_HTML" )
  if [ "$wait" != "" ] ; then
    log "waiting $wait sec : reached the download limit, try again in about $(($wait/60)) minutes"
    sleep $wait  # подождем XX секунд
    continue     # и попробуем снова
  fi

  ## для маленьких файлов <1ћЅ
  # "все слоты для вашей страны исчерпаны"
  # <span class="html_download_api-limit_country"></span>
  if grep -iq "html_download_api-limit_country" "$TEMP_HTML" ; then
    log "waiting 2 min : all downloading slots for your country are busy"
    sleep 120 # подождем 2 минуты
    continue  # и попробуем снова
  fi

  ## для маленьких файлов <1ћЅ
  # "в данное время файл не может быть доступен в связи с проведением обновлений ѕќ"
  # <span class="html_download_api-temporary_unavailable"></span>
  if grep -iq "html_download_api-temporary_unavailable" "$TEMP_HTML" ; then
    log "waiting 2 min : site is temporarily unavailable"
    sleep 120 # подождем 2 минуты
    continue  # и попробуем снова
  fi

  ## для маленьких файлов <1ћЅ
  # ссылка(url3) уже есть?
  # <form action="http://fileshare170.depositfiles.com/auth-123731249105edcb2a5e34d14ddc3e1b-94.181.151.168-152267707-10326272-guest/FS170-10/Madagaskar_2.part09.rar" method="get" onSubmit="download_started();show_begin_popup(0);">
  url=$( sed -n 's/^.*<form action="\([^\"]*\)".*download_started.*$/\1/p' "$TEMP_HTML" | head -n1 )
  if [ "$url" != "" ] ; then
    DLE_LINK=$url
    return $RC_OK
  fi

  # <input type="submit" class="button2" value="Ѕесплатно"/>
  # <input type="hidden" name="gateway_result" value="1"/>
  if ! grep -iq "input.*hidden.*gateway_result" "$TEMP_HTML" ; then
    log "FAILED: Button [Free] not found"
    return $RC_FAIL
  fi

  # поищем url2
  # <form action="/ru/files/8myig3l88/" method="post"><div>
  url=$( sed -n 's/^.*<form action="\([^\"\?]*\)".*$/\1/p' "$TEMP_HTML" )
  # url2 не нашли?
  if [ "$url" = "" ] ; then log "FAILED: URL2 not found"; return $RC_FAIL; fi

  url="http://depositfiles.com${url}"

  log "url2=$url"

  # --------------------------
  log "-- Step.2:"
  # скачаем вторую страницу
  $WGETBIN "$url" -O "$TEMP_HTML" --post-data="gateway_result=1" --quiet
  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # <strong>¬ настоящее время с вашего IP адреса XX.XX.XX.XX<br/> уже идет скачивание.</strong>
  # <a href="http://depositfiles.com/ru/faq.html#simultaneous_downloads_limit">
  # <span class="html_download_api-limit_parallel"></span>
  if grep -iq "html_download_api-limit_parallel" "$TEMP_HTML" ; then
    log "waiting 5 min : Your IP address is already downloading a file"
    sleep 300 # подождем 5 минут
    continue  # и попробуем снова
  fi

  # ¬Ќ»ћјЌ»≈! ¬ы исчерпали лимит подключений! ѕопробуйте повторить через
  # 7 минут(ы).  /  55 секунд(ы).  /  1 час(ов).
  # <a href="http://depositfiles.com/ru/faq.html#after_download_limit">
  # <span class="html_download_api-limit_interval">453</span>
  wait=$( sed -n 's/^.*html_download_api-limit_interval.>\([0-9]*\)<.*$/\1/p' "$TEMP_HTML" )
  if [ "$wait" != "" ] ; then
    log "waiting $wait sec : reached the download limit, try again in about $(($wait/60)) minutes"
    sleep $wait  # подождем XX секунд
    continue     # и попробуем снова
  fi

  # "все слоты для вашей страны исчерпаны"
  # <span class="html_download_api-limit_country"></span>
  if grep -iq "html_download_api-limit_country" "$TEMP_HTML" ; then
    log "waiting 2 min : all downloading slots for your country are busy"
    sleep 120 # подождем 2 минуты
    continue  # и попробуем снова
  fi

  # "в данное время файл не может быть доступен в связи с проведением обновлений ѕќ"
  # <span class="html_download_api-temporary_unavailable"></span>
  if grep -iq "html_download_api-temporary_unavailable" "$TEMP_HTML" ; then
    log "waiting 2 min : site is temporarily unavailable"
    sleep 120 # подождем 2 минуты
    continue  # и попробуем снова
  fi

  # поищем url3
  # <form action="http://fileshare170.depositfiles.com/auth-1237...72-guest/FS170-10/Madagaskar_2.part09.rar" method="get" onSubmit="download_started();show_begin_popup(0);">
  url=$( sed -n 's/^.*<form action="\([^\"]*\)".*download_started.*$/\1/p' "$TEMP_HTML" | head -n1 )
  # url3 не нашли?
  if [ "$url" = "" ] ; then log "FAILED: URL3 not found"; return $RC_FAIL; fi

  # задержку можно не делать - отдаЄт файл и без ожидания

  DLE_LINK=$url
  return $RC_OK

done # while


# ----------------------------------------------------------
# режим - с использованием пароля:

log "mode - with password"

# -- Step.1 ----------------
# получим cookies
$WGETBIN "http://depositfiles.com/en/login.php" -O "$TEMP_HTML" --post-data="login=${login}&password=${password}" --save-cookies="$TEMP_HTML.cookies" --quiet
error=$?  # wget.error ?
if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

# <a id="redirect" href="http://depositfiles.com/gold/">press here</a>
if ! grep -iq "redirect.*gold" "$TEMP_HTML" ; then
  log "FAILED: Invalid Login/Password"
  return $RC_FAIL
fi

log "get cookies - ok"

# -- Step.2 ----------------
# скачаем страницу
$WGETBIN "$1" -O "$TEMP_HTML" --load-cookies="$TEMP_HTML.cookies" --quiet
error=$?  # wget.error ?
if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

# поищем url2
# <a href="http://fileshare121.depositfiles.com/auth-1269...23/FS121-5/vong.zip" onClick="download_started();" class="hide_download_started">—качать файл</a>
url=$( sed -n 's/^.*href="\([^"]*\)".*download_started.*$/\1/p' "$TEMP_HTML" | head -n1 )
# url2 не нашли?
if [ "$url" = "" ] ; then log "FAILED: URL2 not found"; return $RC_FAIL; fi

log "get url2 - ok"

rm "$TEMP_HTML.cookies" 2>/dev/null
DLE_LINK=$url
return $RC_OK
