# plugin: get direct link from http://depositfiles.com
# by Serg0 [30.03.2010]
#
# ����������:
# - ��������� ����� (<1��) �������������� �� 1 ���

TEMP_HTML="${TEMPDIR}dlengine.temp.html"

get_login_password "depositfiles.com"  # ������� �����/������

if [ -z "$password" ]; then
  log "waiting 20 sec"
  sleep 20  # ������� ����� �� ����������� ���������� � depositfiles.com
fi

while true ; do

  if [ -n "$password" ]; then break; fi  # ���� ���� ������

  # --------------------------
  log "-- Step.1:"
  # ������� ������ ��������
  $WGETBIN "$1" -O "$TEMP_HTML" --quiet
  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # ������ ����� �� ���������� ��� �� ��� ������ ��-�� ��������� ��������� ����.
  # <span class="html_download_api-not_exists"></span>
  if grep -iq "html_download_api-not_exists" "$TEMP_HTML" ; then
    log "FAILED: the file not exists"
    return $RC_FAIL
  fi

  ## ��� ��������� ������ <1��
  # <strong>� ��������� ����� � ������ IP ������ XX.XX.XX.XX<br/> ��� ���� ����������.</strong>
  # <a href="http://depositfiles.com/ru/faq.html#simultaneous_downloads_limit">
  # <span class="html_download_api-limit_parallel"></span>
  if grep -iq "html_download_api-limit_parallel" "$TEMP_HTML" ; then
    log "waiting 5 min : Your IP address is already downloading a file"
    sleep 300 # �������� 5 �����
    continue  # � ��������� �����
  fi

  ## ��� ��������� ������ <1��
  # ��������! �� ��������� ����� �����������! ���������� ��������� �����
  # 7 �����(�).  /  55 ������(�).  /  1 ���(��).
  # <a href="http://depositfiles.com/ru/faq.html#after_download_limit">
  # <span class="html_download_api-limit_interval">453</span>
  wait=$( sed -n 's/^.*html_download_api-limit_interval.>\([0-9]*\)<.*$/\1/p' "$TEMP_HTML" )
  if [ "$wait" != "" ] ; then
    log "waiting $wait sec : reached the download limit, try again in about $(($wait/60)) minutes"
    sleep $wait  # �������� XX ������
    continue     # � ��������� �����
  fi

  ## ��� ��������� ������ <1��
  # "��� ����� ��� ����� ������ ���������"
  # <span class="html_download_api-limit_country"></span>
  if grep -iq "html_download_api-limit_country" "$TEMP_HTML" ; then
    log "waiting 2 min : all downloading slots for your country are busy"
    sleep 120 # �������� 2 ������
    continue  # � ��������� �����
  fi

  ## ��� ��������� ������ <1��
  # "� ������ ����� ���� �� ����� ���� �������� � ����� � ����������� ���������� ��"
  # <span class="html_download_api-temporary_unavailable"></span>
  if grep -iq "html_download_api-temporary_unavailable" "$TEMP_HTML" ; then
    log "waiting 2 min : site is temporarily unavailable"
    sleep 120 # �������� 2 ������
    continue  # � ��������� �����
  fi

  ## ��� ��������� ������ <1��
  # ������(url3) ��� ����?
  # <form action="http://fileshare170.depositfiles.com/auth-123731249105edcb2a5e34d14ddc3e1b-94.181.151.168-152267707-10326272-guest/FS170-10/Madagaskar_2.part09.rar" method="get" onSubmit="download_started();show_begin_popup(0);">
  url=$( sed -n 's/^.*<form action="\([^\"]*\)".*download_started.*$/\1/p' "$TEMP_HTML" | head -n1 )
  if [ "$url" != "" ] ; then
    DLE_LINK=$url
    return $RC_OK
  fi

  # <input type="submit" class="button2" value="���������"/>
  # <input type="hidden" name="gateway_result" value="1"/>
  if ! grep -iq "input.*hidden.*gateway_result" "$TEMP_HTML" ; then
    log "FAILED: Button [Free] not found"
    return $RC_FAIL
  fi

  # ������ url2
  # <form action="/ru/files/8myig3l88/" method="post"><div>
  url=$( sed -n 's/^.*<form action="\([^\"\?]*\)".*$/\1/p' "$TEMP_HTML" )
  # url2 �� �����?
  if [ "$url" = "" ] ; then log "FAILED: URL2 not found"; return $RC_FAIL; fi

  url="http://depositfiles.com${url}"

  log "url2=$url"

  # --------------------------
  log "-- Step.2:"
  # ������� ������ ��������
  $WGETBIN "$url" -O "$TEMP_HTML" --post-data="gateway_result=1" --quiet
  error=$?  # wget.error ?
  if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # <strong>� ��������� ����� � ������ IP ������ XX.XX.XX.XX<br/> ��� ���� ����������.</strong>
  # <a href="http://depositfiles.com/ru/faq.html#simultaneous_downloads_limit">
  # <span class="html_download_api-limit_parallel"></span>
  if grep -iq "html_download_api-limit_parallel" "$TEMP_HTML" ; then
    log "waiting 5 min : Your IP address is already downloading a file"
    sleep 300 # �������� 5 �����
    continue  # � ��������� �����
  fi

  # ��������! �� ��������� ����� �����������! ���������� ��������� �����
  # 7 �����(�).  /  55 ������(�).  /  1 ���(��).
  # <a href="http://depositfiles.com/ru/faq.html#after_download_limit">
  # <span class="html_download_api-limit_interval">453</span>
  wait=$( sed -n 's/^.*html_download_api-limit_interval.>\([0-9]*\)<.*$/\1/p' "$TEMP_HTML" )
  if [ "$wait" != "" ] ; then
    log "waiting $wait sec : reached the download limit, try again in about $(($wait/60)) minutes"
    sleep $wait  # �������� XX ������
    continue     # � ��������� �����
  fi

  # "��� ����� ��� ����� ������ ���������"
  # <span class="html_download_api-limit_country"></span>
  if grep -iq "html_download_api-limit_country" "$TEMP_HTML" ; then
    log "waiting 2 min : all downloading slots for your country are busy"
    sleep 120 # �������� 2 ������
    continue  # � ��������� �����
  fi

  # "� ������ ����� ���� �� ����� ���� �������� � ����� � ����������� ���������� ��"
  # <span class="html_download_api-temporary_unavailable"></span>
  if grep -iq "html_download_api-temporary_unavailable" "$TEMP_HTML" ; then
    log "waiting 2 min : site is temporarily unavailable"
    sleep 120 # �������� 2 ������
    continue  # � ��������� �����
  fi

  # ������ url3
  # <form action="http://fileshare170.depositfiles.com/auth-1237...72-guest/FS170-10/Madagaskar_2.part09.rar" method="get" onSubmit="download_started();show_begin_popup(0);">
  url=$( sed -n 's/^.*<form action="\([^\"]*\)".*download_started.*$/\1/p' "$TEMP_HTML" | head -n1 )
  # url3 �� �����?
  if [ "$url" = "" ] ; then log "FAILED: URL3 not found"; return $RC_FAIL; fi

  # �������� ����� �� ������ - ����� ���� � ��� ��������

  DLE_LINK=$url
  return $RC_OK

done # while


# ----------------------------------------------------------
# ����� - � �������������� ������:

log "mode - with password"

# -- Step.1 ----------------
# ������� cookies
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
# ������� ��������
$WGETBIN "$1" -O "$TEMP_HTML" --load-cookies="$TEMP_HTML.cookies" --quiet
error=$?  # wget.error ?
if [ "$error" != "0" ] ; then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

# ������ url2
# <a href="http://fileshare121.depositfiles.com/auth-1269...23/FS121-5/vong.zip" onClick="download_started();" class="hide_download_started">������� ����</a>
url=$( sed -n 's/^.*href="\([^"]*\)".*download_started.*$/\1/p' "$TEMP_HTML" | head -n1 )
# url2 �� �����?
if [ "$url" = "" ] ; then log "FAILED: URL2 not found"; return $RC_FAIL; fi

log "get url2 - ok"

rm "$TEMP_HTML.cookies" 2>/dev/null
DLE_LINK=$url
return $RC_OK
