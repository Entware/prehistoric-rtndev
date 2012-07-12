#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Copyright (C) 2009 Brice DUBOST
# L. Trifonov used as template for tvheadend 
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tvheadend
PKG_VERSION:=2.12.99
PKG_RELEASE:=1

PKG_REV:=d66746ca56b8937d2cf87ca60e51956647b731a5
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/andoma/tvheadend.git
PKG_SOURCE_VERSION:=$(PKG_REV)

EXTRA_CPPFLAGS += \
	-std=gnu99

CONFIGURE_VARS += \
	PKG_CONFIG_LIBDIR="$(STAGING_DIR)/opt/lib/pkgconfig" \
	PKG_CONFIG_PATH="$(STAGING_DIR)/opt/lib/pkgconfig" \

include $(INCLUDE_DIR)/package.mk


define Package/tvheadend
	SECTION:=multimedia
	CATEGORY:=Multimedia
	DEPENDS:=+libopenssl +libpthread +librt
	TITLE:=TVHeadend streaming software
	URL:=https://www.lonelycoder.com/hts/tvheadend_overview.html
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/tvheadend/description
 TVHeadend streaming software
endef

define Build/Configure
	$(call Build/Configure/Default,--disable-avahi --disable-cwc --disable-linuxdvb --disable-v4l --release)
endef

define Package/tvheadend/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build.Linux/tvheadend $(1)/opt/bin/tvheadend
endef

$(eval $(call BuildPackage,tvheadend))
