#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=micro_proxy
PKG_VERSION:=20120812
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)_12jul2012.tar.gz
PKG_SOURCE_URL:=http://www.acme.com/software/$(PKG_NAME)
PKG_MD5SUM:=c984a31611111a6cabfdf96d9f1cb04f

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/micro_proxy
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	DEPENDS:=+xinetd
	TITLE:=micro_proxy free proxy server
	URL:=$(PKG_SOURCE_URL)
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/micro_proxy/description
 micro_proxy is a very small Unix-based HTTP/HTTPS proxy. It runs from inetd,
 which means its performance is poor. But for low-traffic sites, it's quite
 adequate. It implements all the basic features of an HTTP/HTTPS proxy,
 including IPv6 forwarding, in only 320 lines of code.
endef

define Package/micro_proxy/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/micro_proxy $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/xinetd.d
	$(INSTALL_CONF) ./files/micro_proxy $(1)/opt/etc/xinetd.d
endef

$(eval $(call BuildPackage,micro_proxy))
