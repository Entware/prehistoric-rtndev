# plugin: get direct link from http://vip-file.com
# by Serg0 [27.10.2009]

TEMP_HTML="${TEMPDIR}dlengine.temp.html"

get_login_password "vip-file.com"  # ������� ������

while true ; do

  log "-- Step.1:"
  # ������� ������ ��������
  $WGETBIN "$1" -O "$TEMP_HTML" --quiet

  error=$?  # wget.error ?
  if [ "$error" != "0" ] ;  then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # "This file not found"
  if grep -iq "This file not found" "$TEMP_HTML" ; then
    log "FAILED: this file not found"
    return $RC_FAIL
  fi

  # <input name="pass" type="text" class="login" value=""/>
  # <input type="hidden" name="uid" value="c0925a816676" />
  uid=$( sed -n 's/^.*input .*name="uid" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="name" value="vistatransform.zip" />
  name=$( sed -n 's/^.*input .*name="name" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="fid" value="422102" />
  fid=$( sed -n 's/^.*input .*name="fid" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="pin" value="237996" />
  pin=$( sed -n 's/^.*input .*name="pin" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="realuid" value="399e19360254" />
  realuid=$( sed -n 's/^.*input .*name="realuid" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="realname" value="vtp901.zip" />
  realname=$( sed -n 's/^.*input .*name="realname" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="md5crypt" value="aHR0cDovL3I5Ni52aXAtZmlsZS5jb20vZG93bmxvYWQxL2MwOTI1YTgxNjY3Nl96djlnMmlueHc0ZThieTk5L3Zpc3RhdHJhbnNmb3JtLnppcHwyMzc5OTZ8Mzk5ZTE5MzYwMjU0fHZ0cDkwMS56aXB8bGV0aXRiaXQubmV0fDM=" />
  md5crypt=$( sed -n 's/^.*input .*name="md5crypt" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="host" value="letitbit.net" />
  host=$( sed -n 's/^.*input .*name="host" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="ssserver" value="r96" />
  ssserver=$( sed -n 's/^.*input .*name="ssserver" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )
  # <input type="hidden" name="optiondir" value="3" />
  optiondir=$( sed -n 's/^.*input .*name="optiondir" value="\([^"]*\)".*$/\1/p' "$TEMP_HTML" )

  # uid, name, pin, realuid, realname, md5crypt, host, ssserver = "" ?
  # optiondir, fid - ����� ���� ������
  if [ "$uid" = "" -o "$name" = "" -o "$pin" = "" -o "$realuid" = "" -o "$realname" = "" -o "$md5crypt" = "" -o "$host" = "" -o "$ssserver" = "" ] ; then
    log "FAILED: uid/name/pin/realuid/realname/md5crypt/host/ssserver - not found"
    return $RC_FAIL
  fi

  # ���� ������ ���
  if [ "$password" = "" ] ; then
    log "mode - without password"  # ����� - ��� ������

    # ������ ��������� ������
    # <a href="http://vip-file.com/download3/aHR0cD...bmV0fDM=/c0925a816676/vistatransform.zip">��� ������� ����� �������� � ���������</a><br>
    url=$( sed -n 's/^.* href="\([^"]*\)".*��� ������� ����� �������� � ���������.*$/\1/p' "$TEMP_HTML" )

    if [ "$url" = "" ] ;  then
      # ��������� ������ �� �������, ��������� �������������� ��������������� �
      log "free link not found, try self-construct free link"
      url="http://vip-file.com/download3/$md5crypt/$uid/$name"
    fi

    DLE_LINK=$url
    return $RC_OK
  fi

  # ������ ����, �������� ������ ������ �� ������

  # url2:
  # <form action="/sms/check.php" method="post" name="Premium" id="Premium">
  url="http://vip-file.com/sms/check.php"

  #log "url2=$url"

  log "-- Step.2:"
  # ������� ������ ��������
  $WGETBIN "$url" -O "$TEMP_HTML" --post-data="pass=${password}&uid=${uid}&name=${name}&fid=${fid}&pin=${pin}&realuid=${realuid}&realname=${realname}&md5crypt=${md5crypt}&host=${host}&ssserver=${ssserver}&optiondir=${optiondir}" --quiet

  error=$?  # wget.error ?
  if [ "$error" != "0" ] ;  then log "FAILED: wget.error=$error"; return $RC_FAIL; fi

  # �������� ��������� ��������
  head -c 2000 "$TEMP_HTML" >"${TEMP_HTML}.2"
  mv "${TEMP_HTML}.2" "$TEMP_HTML"

  # "Wrong password"
  if grep -iq "Wrong password" "$TEMP_HTML" ; then
    log "FAILED: wrong password"
    return $RC_FAIL
  fi

  # "This password expired"
  if grep -iq "This password expired" "$TEMP_HTML" ; then
    log "FAILED: this password expired"
    return $RC_FAIL
  fi

  # "Reached download limit"
  if grep -iq "Reached download limit" "$TEMP_HTML" ; then
    log "FAILED: reached download limit for this password"
    return $RC_FAIL
  fi

  # ������ url3
  # <br>Your download link:<br><a href='http://r129.letitbit.net/downloadp/bc9742945904_VLJ7LN6R3LN/22738/vip-file.com/12.stulev.1971.02.avi'>http://r129.letitbit.net/downloadp/bc9742945904_VLJ7LN6R3LN/22738/vip-file.com/12.stulev.1971.02.avi</a><br>
  url=$( sed -n "s/^.*Your download link:[^']*'\([^']*\)'.*\$/\1/p" "$TEMP_HTML" )
  # url3 �� �����?
  if [ "$url" = "" ] ;  then log "FAILED: URL3 not found"; return $RC_FAIL; fi

  DLE_LINK=$url
  return $RC_OK

done # while
