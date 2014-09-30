#
# Copyright (C) 2011-2014 Entware, 2012 Zyxmon.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=spdylay
PKG_VERSION:=1.3.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://github.com/tatsuhiro-t/spdylay/releases/download/v$(PKG_VERSION)
PKG_MD5SUM:=6f108778287822f1d07e543ea9a7d501

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/spdylay
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	DEPENDS:=+libevent2-openssl +libevent2 +libxml2 +libstdcpp
	TITLE:=a SPDY C Library
	URL:=https://github.com/tatsuhiro-t/spdylay
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/spdylay/description
 This is an experimental implementation of Google's SPDY protocol in C.
 This library provides SPDY version 2 and 3 framing layer implementation.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/spdylay
	$(CP) $(PKG_INSTALL_DIR)/opt/include/spdylay/*.h \
		$(1)/opt/include/spdylay
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libspdylay.{la,a,so*} \
		$(1)/opt/lib/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libspdylay.pc \
		$(1)/opt/lib/pkgconfig/
endef

define Package/spdylay/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{shrpx,spdycat,spdyd} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libspdylay.so* $(1)/opt/lib
endef

$(eval $(call BuildPackage,spdylay))
