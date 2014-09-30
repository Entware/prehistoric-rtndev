#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libev
PKG_VERSION:=4.19
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://dist.schmorp.de/libev
PKG_MD5SUM:=01d1c672697f649b4f94abd0b70584ff

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libev
	SECTION:=libs
	CATEGORY:=Libraries
	TITLE:=event loop library
	URL:=http://software.schmorp.de/pkg/libev
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/libev/description
 A full-featured and high-performance event loop that is loosely modelled after
 libevent, but without its limitations and bugs.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/ev.h $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/ev++.h $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/event.h $(1)/opt/include/ev_event.h
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libev.{a,la,so*} $(1)/opt/lib/
endef

define Package/libev/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libev.so* $(1)/opt/lib
endef

$(eval $(call BuildPackage,libev))
