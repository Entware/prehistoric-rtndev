#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy
PKG_VERSION:=1.4.0
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.dnscrypt.org/dnscrypt-proxy/
PKG_MD5SUM:=c31d14d8de2123e9f2ddf26216577841

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/dnscrypt-proxy/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	DEPENDS:=+libsodium
	TITLE:=A tool for securing communications between a client and a DNS resolver
	URL:=http://www.opendns.com/technology/dnscrypt
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/dnscrypt-proxy
	$(call Package/dnscrypt-proxy/Default)
endef

define Package/dnscrypt-proxy-hostip
	$(call Package/dnscrypt-proxy/Default)
	TITLE+= (a resolver before dnscrypt-proxy start)
endef

define Package/dnscrypt-proxy/description
 dnscrypt-proxy is a slight variation on DNSCurve.
 DNSCurve improves the confidentiality and integrity of DNS requests using
 high-speed high-security elliptic-curve cryptography. Best of all, DNSCurve
 has very low overhead and adds virtually no latency to queries.
endef

define Package/dnscrypt-proxy-hostip/description
 A tool for resolving a name before dnscrypt-proxy. It should help fighting
 the chicken-and-egg issue seen on routers, where dnscrypt-proxy requires
 a working NTP server, but the NTP server requires a working resolver.
endef

CONFIGURE_ARGS += \
	--disable-ssp

define Package/dnscrypt-proxy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/dnscrypt-proxy $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/share/dnscrypt-proxy
	$(INSTALL_DATA) \
	    $(PKG_INSTALL_DIR)/opt/share/dnscrypt-proxy/dnscrypt-resolvers.csv \
	    $(1)/opt/share/dnscrypt-proxy
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S09dnscrypt-proxy $(1)/opt/etc/init.d/
endef

define Package/dnscrypt-proxy-hostip/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/hostip $(1)/opt/sbin/dnscrypt-proxy-hostip
endef

define Package/dnscrypt-proxy/postinst
#!/bin/sh

[ -z "$$(which grep)" ] && exit 0
[ -z "$$(which awk)" ] && exit 0

echo "By default, dnscrypt-proxy will use the OpenDNS dnscrypt server."
echo "You may choose another one if you wish:"

SRVLIST=/opt/share/dnscrypt-proxy/dnscrypt-resolvers.csv
i=0
for serv in $$(cat $$SRVLIST | awk -F "," "{print \$$1}")
do
    fullname=$$(grep "^$$serv," $$SRVLIST | awk -F "," "{print \$$2}" )
    if [ ! $$i -eq 0 ]
    then
        echo "$$i) $$serv ($$fullname)"
    fi
    i=`expr $$i + 1`
done
read -p "Choose server from list or hit Enter to continue [1-`expr $$i - 1`]: " OPTION
[ -z "$$OPTION" ] && exit 0
srv=none
i=0
for serv in $$(cat $$SRVLIST | awk -F "," "{print \$$1}")
do
    if [ ! $$i -eq 0 ] && [ $$i -eq $$OPTION ]
    then
	srv=$$serv
	break
    fi
    i=`expr $$i + 1`
done
[ "$$srv" == "none" ] && exit 0
SCRIPT=/opt/etc/init.d/S09dnscrypt-proxy
cat > $$SCRIPT << EOF
#!/bin/sh

ENABLED=yes
PROCS=dnscrypt-proxy
ARGS="--local-address=127.0.0.1:65053 --daemonize -R $$srv"
PREARGS=""
DESC=$$PROCS
PATH=/opt/sbin:/opt/bin:/opt/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

. /opt/etc/init.d/rc.func

EOF
chmod +x $$SCRIPT
endef
$(eval $(call BuildPackage,dnscrypt-proxy))
$(eval $(call BuildPackage,dnscrypt-proxy-hostip))
