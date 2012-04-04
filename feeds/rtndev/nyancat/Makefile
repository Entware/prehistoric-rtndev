#
# Copyright (C) 2007-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nyancat
PKG_VERSION:=0.1
PKG_REV:=5a88b86b6abe3aae7f8c1e6f7545f2cc2ed260d7
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=git://github.com/klange/nyancat.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/nyancat
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Nyancat rendered in your terminal
  URL:=$(PKG_SOURCE_URL)
endef

define Package/nyancat/description
	Nyancat rendered in your terminal.
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/src \
	    LFLAGS="$(TARGET_CFLAGS) $(TARGET_LDFLAGS)" \
	    CC="$(TARGET_CC)"
endef

define Package/nyancat/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/nyancat $(1)/opt/bin/
endef

$(eval $(call BuildPackage,nyancat))
