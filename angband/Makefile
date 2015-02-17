#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Thanks to MercuryV @ wl500g.info
#

include $(TOPDIR)/rules.mk

PKG_NAME:=angband
PKG_VERSION:=3.5.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://rephial.org/downloads/3.5/
PKG_MD5SUM:=3b9a324551cfd48b101f197a8441f135

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/angband
	SECTION:=games
	CATEGORY:=Games
	DEPENDS:=+libncursesw
	TITLE:=single-player, text-based, dungeon simulation game
	URL:=http://rephial.org
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/angband/description
 Angband is a single-player, text-based, dungeon simulation derived from
 the game Moria, which was in turn based on Rogue. It is often described
 as a \"roguelike\" game because the look and feel of the game is still
 quite similar to Rogue.
endef

CONFIGURE_ARGS += \
	--disable-x11 \
	--with-private-dirs \

define Package/angband/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/angband $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/angband/{edit,pref}
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/angband/edit/*.txt $(1)/opt/etc/angband/edit
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/angband/pref/*.prf $(1)/opt/etc/angband/pref
	$(INSTALL_DIR) $(1)/opt/share/angband/{file,help,info}
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/angband/file/*.txt $(1)/opt/share/angband/file
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/angband/help/*.{txt,hlp} $(1)/opt/share/angband/help
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/angband/info/*.txt $(1)/opt/share/angband/info
endef

$(eval $(call BuildPackage,angband))
