# plugin: get direct link from http://letitbit.net
# by Serg0 [02.08.2010]

TEMP_HTML="${TEMPDIR}dlengine.temp.html"
MAX_pTRY=5  # число попыток получить прямую ссылку

get_login_password "letitbit.net"  # получим логин/пароль
pTry=0
while [ $pTry -lt $MAX_pTRY ]; do
  pTry=$(($pTry+1))

  # --------------------------
  log "-- Step.1: (try.$pTry)"
  # скачаем 1-ю страницу
  $WGETBIN "$1" -O "$TEMP_HTML" --post-data="vote_cr=en" --quiet
  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # "Request file Smyvajsya.rar Deleted"
  if grep -iq "Deleted" "$TEMP_HTML" ; then log "FAILED: this file not found"; return $RC_FAIL; fi

  # поищем url2
  # <div class="dlBlock" id="dvifree">  - начало секции Free
  # <form action="http://letitbit.net/download4.php" method="post">
  url=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*<form.* action="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # url2 не нашли?
  if [ "$url" = "" ] ; then log "FAILED: URL2 not found"; return $RC_FAIL; fi

  # параметры формы:
  # <input type="hidden" name="md5crypt" value="aHR0cDovL3IzOS5...YjM2dGJpdC5uZXR8Mg==" />
  md5crypt=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="md5crypt" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input name="frameset2" type="submit" ... value='Download file.' />
  #   frameset2='Download file.'
  # <input type="hidden" name="uid5" value="900e45126feb5be48e74db2a5ce98620" />
  uid5=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="uid5" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="uid" value="17b26f1e40bd532" />
  uid=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="uid" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="name" value="Pingviny.iz.Madagaskara.Zapusk.2008.XviD.SATRip.avi" />
  name=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="name" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="pin" value="764570" />
  pin=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="pin" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="realuid" value="6cfb3687cf04268" />
  realuid=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="realuid" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="realname" value="Pingviny.iz.Madagaskara.3_Zapusk.avi" />
  realname=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="realname" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="host" value="letitbit.net" />
  host=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="host" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="ssserver" value="r39" />
  ssserver=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="ssserver" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="sssize" value="104880128" />
  sssize=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="sssize" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="optiondir" value="2" />
  optiondir=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="optiondir" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="pin_wm" value="" />
  pin_wm=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="pin_wm" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="ref_rem" value="" />
  ref_rem=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="ref_rem" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="lsarrserverra" value="s7.letitbit.net" />
  lsarrserverra=$( sed -n '/div.*dvifree/,/\/form/!d; s/^.*input .*name="lsarrserverra" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )

  # md5crypt, uid5, uid, name, pin, realuid, realname, host, ssserver, sssize = "" ?
  # optiondir, pin_wm, ref_rem, lsarrserverra - может быть пустым
  if [ "$md5crypt" = "" -o "$uid5" = "" -o "$uid" = "" -o "$name" = "" -o "$pin" = "" -o "$realuid" = "" -o "$realname" = "" -o "$host" = "" -o "$ssserver" = "" -o "$sssize" = "" ] ; then
    log "FAILED: md5crypt/uid5/uid/name/pin/realuid/realname/host/ssserver/sssize - not found"
    return $RC_FAIL
  fi

  if [ -n "$password" ]; then break; fi  # если есть пароль

  # --------------------------
  # отсылает на дополнительную страницу на vip-file.com ?
  if { echo "$url" | grep -iqF 'http://vip-file.com/' ;} ; then
    log "-- Step.1b:"
    # скачаем страницу
    $WGETBIN "$url" -O "$TEMP_HTML" --post-data="md5crypt=${md5crypt}&frameset2=Download+file.&uid5=${uid5}&uid=${uid}&name=${name}&pin=${pin}&realuid=${realuid}&realname=${realname}&host=${host}&ssserver=${ssserver}&sssize=${sssize}&optiondir=${optiondir}&pin_wm=${pin_wm}&ref_rem=${ref_rem}&lsarrserverra=${lsarrserverra}" --quiet
    error=$?  # wget.error ?
    if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

    # поищем url2
    # <form action="http://letitbit.net/download4.php" method="post">
    url=$( sed -n 's/^.*<form.* action="\([^"]*\)".*$/\1/p' "$TEMP_HTML" | head -n1 )
    # url2 не нашли?
    if [ "$url" = "" ] ; then log "FAILED: URL2 not found"; return $RC_FAIL; fi
  fi

  # --------------------------
  log "-- Step.2:"
  # скачаем 2-ю страницу
  $WGETBIN "$url" -O "$TEMP_HTML" --post-data="md5crypt=${md5crypt}&frameset2=Download+file.&uid5=${uid5}&uid=${uid}&name=${name}&pin=${pin}&realuid=${realuid}&realname=${realname}&host=${host}&ssserver=${ssserver}&sssize=${sssize}&optiondir=${optiondir}&pin_wm=${pin_wm}&ref_rem=${ref_rem}&lsarrserverra=${lsarrserverra}" --save-cookies="$TEMP_HTML.cookies" --keep-session-cookies --quiet
  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # поищем url3
  # <form action="http://letitbit.net/download3.php" method="post" id="dvifree">
  url=$( sed -n 's/^.*<form.* action="\([^"]*\)".*dvifree.*$/\1/p' "$TEMP_HTML" )
  # url3 не нашли?
  if [ "$url" = "" ] ; then log "FAILED: URL3 not found"; return $RC_FAIL; fi

  # параметры формы:
  # каптча:
  # <img src='http://letitbit.net/cap.php?jpg=2f1f200c978eb597ee45c78ec5.jpg' border='0'>
  url_captcha=$( sed -n "s/^.*img src='\([^']*cap\.php[^']*\)'.*\$/\1/p" "$TEMP_HTML" )
  # <input type='text' ... name='cap' ...>
  #   cap='XXXXXX'
  # <input type="hidden" name="uid2" value="17b26f1e40bd532" />
  uid2=$( sed -n 's/^.*input .*name="uid2" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )

  # url_captcha, uid2 = "" ?
  if [ "$url_captcha" = "" -o "$uid2" = "" ] ; then
    log "FAILED: url_captcha/uid2 - not found"
    return $RC_FAIL
  fi

  # остальные параметры имеют такое же значение, что и на предыдущей странице:
  # frameset, md5crypt, uid5, uid, name, pin, realuid, realname, host, ssserver, sssize, optiondir, pin_wm

  # получим картинку каптчи по $url_captcha и распознаем её --> $captcha
  . "$PLUGINS_DIR/letitbit.net.captcha.sh"
  # captcha.error ?
  if [ "$?" != "0" ] ; then log "FAILED: CAPTCHA is NOT RECOGNIZED"; return $RC_FAIL; fi

  log "captcha=$captcha"

  # --------------------------
  log "-- Step.3:"
  # скачаем 3-ю страницу
  $WGETBIN "$url" -O "$TEMP_HTML" --post-data="cap=${captcha}&uid2=${uid2}&md5crypt=${md5crypt}&frameset=Download+file.&uid5=${uid5}&uid=${uid}&name=${name}&pin=${pin}&realuid=${realuid}&realname=${realname}&host=${host}&ssserver=${ssserver}&sssize=${sssize}&optiondir=${optiondir}&pin_wm=${pin_wm}" --load-cookies="$TEMP_HTML.cookies" --quiet
  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # Отказ? плохая каптча?
  # <script language='javascript' type='text/javascript'>javascript:history.go(-1);</script>
  if grep -iqF 'javascript:history.go(-1)' "$TEMP_HTML" ; then
    log "FAILED: request DENIED (bad captcha?)"
    continue  # попробуем снова
  fi

  # поищем url4
  # <frame src="http://letitbit.net/tmpl/tmpl_frame_top.php?link=" name="topFrame" ... />
  url=$( sed -n 's/^.*frame.*src="\([^"]*\)".*name="topFrame".*$/\1/p' "$TEMP_HTML" )
  # url4 не нашли?
  if [ "$url" = "" ] ; then log "FAILED: URL4 not found"; return $RC_FAIL; fi

  # --------------------------
  log "-- Step.4:"
  # скачаем 4-ю страницу
  $WGETBIN "$url" -O "$TEMP_HTML" --load-cookies="$TEMP_HTML.cookies" --quiet
  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # поищем url5
  # window.location.href="http://letitbit.net/tmpl/tmpl_frame_top.php";
  url=$( sed -n 's/^.*window.location.href="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # url5 не нашли?
  if [ "$url" = "" ] ; then log "FAILED: URL5 not found"; return $RC_FAIL; fi

  # <div id="countdown" ...><b>Дождитесь своей очереди<br /><span id="errt">60</span> секунд</b>
  wait=$( sed -n 's/^.*countdown.*<span id="errt">\([0-9]*\)<.*$/\1/p' "$TEMP_HTML" )
  # wait не нашли?
  if [ "$wait" = "" ] ; then log "FAILED: countdown seconds - not found"; return $RC_FAIL; fi

  log "waiting $wait sec : Wait your turn $wait seconds"
  sleep $wait  # ждем XX секунд

  # --------------------------
  log "-- Step.5:"
  # скачаем 5-ю страницу
  $WGETBIN "$url" -O "$TEMP_HTML" --load-cookies="$TEMP_HTML.cookies" --quiet
  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # Изменился ip-адрес сервера?
  # <div id="countdown" ...><b>Дождитесь своей очереди<br /><span id="errt">100</span> секунд</b>
  if grep -iq 'countdown.*"errt"' "$TEMP_HTML" ; then
    log "FAILED: other server?"
    continue  # попробуем снова
  fi

  # поищем url6
  # <a onClick="DownloadClick();" href="http://94.198.240.60/download50/54d9c1468900_46qyUzAAqT4HegXM/611664/letitbit.net/MagVoVoKrKr.zip">Ваша ссылка на скачивание файла</a>
  url=$( sed -n 's/^.*DownloadClick.*href="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # url6 не нашли?
  if [ "$url" = "" ] ; then log "FAILED: URL6 not found"; return $RC_FAIL; fi

  # ПРЯМАЯ ССЫЛКА ПОЛУЧЕНА
  DLE_LINK=$url

  rm "$TEMP_HTML.cookies" 2>/dev/null
  return $RC_OK

done # while pTry

[ -z "$password" ]  &&  return $RC_FAIL  # если без пароля


# ----------------------------------------------------------
# режим - с использованием пароля:

log "mode - with password"

# --------------------------
log "-- Step.2:"
url="http://letitbit.net/sms/check2.php"
# скачаем страницу
$WGETBIN "$url" -O "$TEMP_HTML" --post-data="pass=${password}&uid5=${uid5}&uid=${uid}&name=${name}&pin=${pin}&realuid=${realuid}&realname=${realname}&host=${host}&ssserver=${ssserver}&sssize=${sssize}&optiondir=${optiondir}&pin_wm=${pin_wm}" --header="Cookie:lang=en" --quiet
error=$?  # wget.error ?
if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

# поищем url3
# <a href='http://78.108.179.56/downloadp9/.../zapovednik.avi' title='Your link to file download' ...>
url=$( sed -n "s/^.*href='\([^']*\)'.*Your link to file download.*\$/\1/p" "$TEMP_HTML" )
# url3 не нашли?
if [ "$url" = "" ] ; then log "FAILED: URL3 not found. Bad password?"; return $RC_FAIL; fi

DLE_LINK=$url
return $RC_OK
