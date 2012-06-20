#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=25volt
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://25volt.ru/download
PKG_MD5SUM:=40e1ab11fd6f9026f5c97fb049771fc1

include $(INCLUDE_DIR)/package.mk

define Package/25volt
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+libusb
	TITLE:=25volt a tool for monitoring ups POWERCOM Imperial series
	URL:=http://25volt.ru
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/25volt/description
 25volt - A lightweight tool for monitoring ups POWERCOM Imperial IMD-1025AP
 and maybe other for FreeBSD and Linux.
endef

define Build/Compile
	$(TARGET_CC) $(TARGET_CFLAGS) -c -I$(STAGING_DIR)/opt/include -o $(PKG_BUILD_DIR)/main.o $(PKG_BUILD_DIR)/main.c
	$(TARGET_CC) $(TARGET_LDFLAGS) -L$(STAGING_DIR)/opt/lib -o $(PKG_BUILD_DIR)/25volt $(PKG_BUILD_DIR)/main.o -lusb
endef

define Package/25volt/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/25volt $(1)/opt/bin
endef

$(eval $(call BuildPackage,25volt))
