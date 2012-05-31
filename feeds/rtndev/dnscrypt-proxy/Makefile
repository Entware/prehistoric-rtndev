#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy
PKG_VERSION:=0.9.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://github.com/opendns/dnscrypt-proxy/downloads
PKG_MD5SUM:=b13fdb10f7ab2b50e94545925dad59de
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/dnscrypt-proxy
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A tool for securing communications between a client and a DNS resolver
	URL:=http://www.opendns.com/technology/dnscrypt
	SUBMENU:=IP Addresses and Names
endef

define Package/dnscrypt-proxy/description
	dnscrypt-proxy is a slight variation on DNSCurve.
	DNSCurve improves the confidentiality and integrity of DNS requests using 
	high-speed high-security elliptic-curve cryptography. Best of all, DNSCurve 
	has very low overhead and adds virtually no latency to queries.
endef

CONFIGURE_VARS += \
	ax_cv_check_cflags___fstack_protector_all=no

define Package/dnscrypt-proxy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/dnscrypt-proxy $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S09dnscrypt-proxy $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,dnscrypt-proxy))