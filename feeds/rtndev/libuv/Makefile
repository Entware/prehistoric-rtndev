#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libuv
PKG_VERSION:=2c983fb994
PKG_RELEASE:=1
PKG_REV:=2c983fb99489383e12b046a5682b5b12b00d9d19

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=git://github.com/joyent/libuv.git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git

include $(INCLUDE_DIR)/package.mk

define Package/libuv
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=https://github.com/joyent/libuv
  TITLE:=libuv is a new platform layer for Node
endef

define Package/libuv/description
  libuv is a new platform layer for Node. Its purpose is to abstract libev
  on Unix systems.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_BUILD_DIR)/include/* $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/uv.a $(1)/opt/lib/
endef

$(eval $(call BuildPackage,libuv))
