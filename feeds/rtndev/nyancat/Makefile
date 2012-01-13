#
# Copyright (C) 2007-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nyancat
PKG_VERSION:=0.2
PKG_REV:=71bb300117f4fd0a0acc16c8fd97079acb00a29f
PKG_RELEASE:=1


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

define Build/Configure
endef

define Buid/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
	    $(TARGET_CONFIGURE_OPTS) \
	    CFLAGS="$(TARGET_CFLAGS) -I./include/ $(TARGET_CPPFLAGS)" \
	    LDFLAGS="$(TARGET_LDFLAGS) -lmad -lao -lpthread"
endef

define Package/nyancat/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/nyancat $(1)/opt/bin/
endef

$(eval $(call BuildPackage,nyancat))

