#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=squeezelite
PKG_VERSION:=1.6.4
PKG_REV:=75a72d5f86e1675b5c5892ee5fb2278bbe8dc695
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://code.google.com/p/squeezelite/
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/squeezelite
	SECTION:=sound
	CATEGORY:=Sound
	DEPENDS:=+alsa-lib +libmpg123
	TITLE:=headless squeezebox emulator
	URL:=https://code.google.com/p/squeezelite/
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/squeezelite/description
 Squeezelite is a small headless squeezebox emulator for linux
 using alsa audio output.
endef

TARGET_LDFLAGS += \
	-lasound \
	-lpthread \

define Package/squeezelite/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/squeezelite $(1)/opt/bin/
endef

$(eval $(call BuildPackage,squeezelite))
