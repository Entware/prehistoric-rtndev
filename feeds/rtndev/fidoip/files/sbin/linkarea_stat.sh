#!/bin/sh
cat /opt/etc/fido/config | grep EchoArea  > /opt/var/fido/hpt.area
/opt/bin/perl /opt/sbin/hpt_area.pl /opt/var/fido/hpt.area

