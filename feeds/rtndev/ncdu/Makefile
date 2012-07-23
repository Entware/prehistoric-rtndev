#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ncdu
PKG_VERSION:=1.8
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://dev.yorhel.nl/download/
PKG_MD5SUM:=94d7a821f8a0d7ba8ef3dd926226f7d5

include $(INCLUDE_DIR)/package.mk

define Package/ncdu
	SECTION:=utils
	CATEGORY:=Utilities
	SUBMENU:=disc
	DEPENDS:=+libncursesw
	TITLE:=NCurses Disk Usage
	URL:=http://dev.yorhel.nl/ncdu
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/ncdu/description
 ncdu is a disk usage analyzer with an ncurses interface, aimed to be run on a remote server
endef

CONFIGURE_ARGS += \
        --prefix=/opt

define Package/ncdu/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ncdu $(1)/opt/bin
endef

$(eval $(call BuildPackage,ncdu))
