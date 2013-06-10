#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ncdu
PKG_VERSION:=1.10
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://dev.yorhel.nl/download/
PKG_MD5SUM:=7535decc8d54eca811493e82d4bfab2d

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

define Package/ncdu/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ncdu $(1)/opt/bin
endef

$(eval $(call BuildPackage,ncdu))
