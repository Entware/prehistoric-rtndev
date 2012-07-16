#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nyancat
PKG_VERSION:=1.0
PKG_REV:=c035cf7f9ba1fdc07f77d6fa2e37e1e48c6ee3dd
PKG_RELEASE:=2

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
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
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
