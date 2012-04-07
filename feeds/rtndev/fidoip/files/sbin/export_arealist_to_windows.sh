#!/bin/sh
cat /opt/etc/fido/config | grep EchoArea | sed "s|\/opt\/var\/fido\/msgbasedir/|\\\opt\\\var\\\fido\\\msgbasedir\\\|g" > /opt/var/fido/config.unx
