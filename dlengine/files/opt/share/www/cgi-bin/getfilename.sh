#!/opt/bin/bash

. /opt/var/lib/dlengine/utils

function cgi_decodevar()
{
    [ $# -ne 1 ] && return
    local v t h
    # replace all + with whitespace and append %%
    t="${1//+/ }%%"
    while [ ${#t} -gt 0 -a "${t}" != "%" ]; do
    v="${v}${t%%\%*}" # digest up to the first %
    t="${t#*%}"       # remove digested part
    # decode if there is anything to decode and if not at end of string
    if [ ${#t} -gt 0 -a "${t}" != "%" ]; then
        h=${t:0:2} # save first two chars
        t="${t:2}" # remove these
        v="${v}"`echo -e \\\\x${h}` # convert hex to special char
    fi
    done
    # return decoded string
    echo "${v}"
    return
}

# routine to get variables from http requests 
# usage: cgi_getvars method varname1 [.. varnameN]
# method is either GET or POST or BOTH
# the magic varible name ALL gets everything
# from oinkzwurgl.org/bash_cgi

function cgi_getvars()
{
    [ $# -lt 2 ] && return
    local q p k v s
    # get query
    case $1 in
    GET)
        [ ! -z "${QUERY_STRING}" ] && q="${QUERY_STRING}&"
        ;;
    POST)
        cgi_get_POST_vars
        [ ! -z "${QUERY_STRING_POST}" ] && q="${QUERY_STRING_POST}&"
        ;;
    BOTH)
        [ ! -z "${QUERY_STRING}" ] && q="${QUERY_STRING}&"
        cgi_get_POST_vars
        [ ! -z "${QUERY_STRING_POST}" ] && q="${q}${QUERY_STRING_POST}&"
        ;;
    esac
    shift
    s=" $* "
    # parse the query data
    while [ ! -z "$q" ]; do
    p="${q%%&*}"  # get first part of query string
    k="${p%%=*}"  # get the key (variable name) from it
    v="${p#*=}"   # get the value from it
    q="${q#$p&*}" # strip first part from query string
    # decode and evaluate var if requested
    [ "$1" = "ALL" -o "${s/ $k /}" != "$s" ] && \
        eval "$k=\"`cgi_decodevar \"$v\"`\""
    done
    return
}

cgi_getvars GET addurl

FILENAME=`curl "$addurl" -D- -r 0-1 2>/dev/null|grep "ontent-disposition"|cut -f2 -d"="`;
if [ -z "$FILENAME" ]; then
  FILENAME=`echo "$addurl" | sed -e 's/.*\///'`;
fi
FILENAME=`echo "$FILENAME"| sed -e 's/\"//g'`;
echo "<input type=text name=loc_fname size=25 value='$FILENAME'>"
