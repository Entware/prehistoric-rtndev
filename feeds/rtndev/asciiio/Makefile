#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asciiio
PKG_VERSION:=0.x
PKG_RELEASE:=3

PKG_REV:=51ac1f103795d8f05da201eedd4c947252b58c4b
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/sickill/ascii.io-cli.git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/asciiio
	SECTION:=utils
	CATEGORY:=Utilities
	SUBMENU:=Terminal
	DEPENDS:=+python +python-bzip2 +ncurses-bin +curl
	TITLE:=A terminal sessions recorder
	URL:=http://ascii.io
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/asciiio/description
 ascii.io lets you record your terminal sessions and share it with other geeks.
endef

define Package/asciiio/conffiles
/opt/etc/ascii.io/config
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/asciiio/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/asciiio $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/ascii.io
endef

$(eval $(call BuildPackage,asciiio))
