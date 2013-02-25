#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shairport
PKG_VERSION:=0.05-20130121
PKG_RELEASE:=1

PKG_REV:=fd50ed068cbf0ab275d2ff0f25ed73ebf793927f
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/skaman/shairport.git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/shairport
	SECTION:=sound
	CATEGORY:=Sound
	DEPENDS:=+libao +libopenssl
	TITLE:=an AirPort Express emulator
	URL:=http://github.com/albertz/shairport
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/shairport/description
 This program emulates an AirPort Express for the purpose of streaming music
 from iTunes and compatible iPods. It implements a server for the Apple RAOP
 protocol. ShairPort does not support AirPlay v2 (video and photo streaming).
endef

TARGET_LDFLAGS += -lssl -lcrypto -lao -lm

define Package/shairport/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin/
endef

$(eval $(call BuildPackage,shairport))
