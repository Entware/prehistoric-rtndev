#
# Copyright (C) 2011-2012 Entware, 2012 Zyxmon.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=3proxy
PKG_VERSION:=0.6.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=http://www.3proxy.ru/0.6.1
PKG_MD5SUM:=03790467a12e16ed8785ae688ecf9b68

include $(INCLUDE_DIR)/package.mk

define Package/3proxy
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=3proxy free proxy server
	URL:=http://www.3proxy.ru
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/3proxy/description
 3proxy is universal proxy server. It can be used to provide internal users
 with fully controllable access to external resources or to provide external
 users with access to internal resources.
endef

define Package/3proxy/conffiles
/opt/etc/3proxy/3proxy.cfg
/opt/etc/3proxy/bandlimiters
/opt/etc/3proxy/counters
/opt/etc/3proxy/passwd
endef

define Build/Configure
	$(CP) $(PKG_BUILD_DIR)/Makefile.Linux $(PKG_BUILD_DIR)/Makefile
endef

define Package/3proxy/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/src/3proxy \
		$(PKG_BUILD_DIR)/src/countersutil \
		$(PKG_BUILD_DIR)/src/dighosts \
		$(PKG_BUILD_DIR)/src/ftppr \
		$(PKG_BUILD_DIR)/src/mycrypt \
		$(PKG_BUILD_DIR)/src/pop3p \
		$(PKG_BUILD_DIR)/src/proxy \
		$(PKG_BUILD_DIR)/src/socks \
		$(PKG_BUILD_DIR)/src/tcppm \
		$(PKG_BUILD_DIR)/src/udppm  $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DIR) $(1)/opt/etc/3proxy
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/scripts/3proxy.cfg $(1)/opt/etc/3proxy
	touch $(1)/opt/etc/3proxy/passwd
	touch $(1)/opt/etc/3proxy/counters
	touch $(1)/opt/etc/3proxy/bandlimiters
	chmod 0600 $(1)/opt/etc/3proxy/*
	$(CP) $(PKG_BUILD_DIR)/scripts/add3proxyuser.sh $(1)/opt/etc/3proxy
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S23proxy $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,3proxy))
