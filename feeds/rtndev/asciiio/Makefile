#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asciiio
PKG_VERSION:=a69caa6c48
PKG_RELEASE:=1

PKG_REV:=a69caa6c4885f35e3795d9bf07f5c0ace5f7b241
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
	DEPENDS:=+python +python-bzip2 +coreutils-stty +curl
	TITLE:=A terminal sessions recorder
	URL:=http://ascii.io
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/asciiio/description
 ascii.io lets you record your terminal sessions and share it with other geeks.
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/asciiio/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/asciiio.py $(1)/opt/bin/asciiio
	$(INSTALL_DIR) $(1)/opt/etc/ascii.io
endef

$(eval $(call BuildPackage,asciiio))
