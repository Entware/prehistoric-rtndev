#!/bin/sh
cat /opt/var/fido/config.win | grep EchoArea | sed "s|\/opt\/var\/fido\msgbasedir\/|\\\opt\\\var\\\fido\\\msgbasedir\\\|g"
