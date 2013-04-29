#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy
PKG_VERSION:=1.3.0-20130427
PKG_RELEASE:=1

PKG_REV:=445bd07d3e994156dcac7aca75a3985d0a6ba287
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/opendns/dnscrypt-proxy.git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/dnscrypt-proxy/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=A tool for securing communications between a client and a DNS resolver
	URL:=http://www.opendns.com/technology/dnscrypt
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
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

TARGET_CFLAGS += \
	-std=gnu99 \
	-fPIC

define Package/dnscrypt-proxy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/dnscrypt-proxy $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S09dnscrypt-proxy $(1)/opt/etc/init.d/
endef

define Package/dnscrypt-proxy-hostip/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/hostip $(1)/opt/sbin/dnscrypt-proxy-hostip
endef

$(eval $(call BuildPackage,dnscrypt-proxy))
$(eval $(call BuildPackage,dnscrypt-proxy-hostip))
