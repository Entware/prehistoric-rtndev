#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=temper
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=http://www.relavak.com/downloads
PKG_MD5SUM:=aab4888f351e110e252335ab5dc143f4

include $(INCLUDE_DIR)/package.mk

define Package/temper
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+libusb-compat
	TITLE:=TEMPer Temperature Sensor Linux Driver
	URL:=http://relavak.wordpress.com/2009/10/17/temper-temperature-sensor-linux-driver
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/temper/description
 A USB temperature data logger for a cheap USB thermometer dongles.
endef

define Build/Configure
	$(RM) $(PKG_BUILD_DIR)/temper
endef

define Build/Compile
	$(TARGET_CC) -DUNIT_TEST $(TARGET_CFLAGS) -c -I$(STAGING_DIR)/opt/include -o $(PKG_BUILD_DIR)/temper.o $(PKG_BUILD_DIR)/temper.c
	$(TARGET_CC) $(TARGET_LDFLAGS) -L$(STAGING_DIR)/opt/lib -o $(PKG_BUILD_DIR)/temper $(PKG_BUILD_DIR)/temper.o -lusb
endef

define Package/temper/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/temper $(1)/opt/bin
endef

$(eval $(call BuildPackage,temper))
