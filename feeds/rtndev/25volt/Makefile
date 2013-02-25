#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=25volt
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/25volt
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+libusb-compat
	TITLE:=25volt a tool for monitoring ups POWERCOM Imperial series
	URL:=http://25volt.ru
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/25volt/description
 25volt - A lightweight tool for monitoring ups POWERCOM Imperial IMD-1025AP
 and maybe other for FreeBSD and Linux.
endef

define Build/Prepare
	$(INSTALL_DIR) $(PKG_BUILD_DIR)
	$(INSTALL_DATA) ./src/main.c $(PKG_BUILD_DIR)/
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
