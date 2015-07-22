#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mpg123
PKG_VERSION:=1.22.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.mpg123.de/download
PKG_MD5SUM:=6f6d2178c354f39207bf97e062936110

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/mpg123/Default
	TITLE:=fast console MPEG Audio
	URL:=http://www.mpg123.de/
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/libmpg123
$(call Package/mpg123/Default)
	SECTION:=libs
	CATEGORY:=Libraries
	SUBMENU:=Sound
	DEPENDS:=+libltdl
	TITLE:=$(PKG_TITLE) decoder library
endef

define Package/mpg123
$(call Package/mpg123/Default)
	SECTION:=sound
	CATEGORY:=Sound
	DEPENDS:=+libmpg123
	TITLE:=$(PKG_TITLE) player
endef

define Package/libmpg123/description
 Fast console MPEG Audio decoder library.
endef

define Package/mpg123/description
 Fast console MPEG Audio Player.
endef

CONFIGURE_ARGS += \
	--enable-static \
	--enable-shared \
	--with-cpu=generic_nofpu \
	--with-default-audio=alsa \

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/mpg123.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libmpg123.{a,la,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libmpg123.pc $(1)/opt/lib/pkgcon
endef

define Package/libmpg123/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libmpg123.so* $(1)/opt/lib
endef

define Package/mpg123/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/mpg123{,-id3dump,-strip} \
	    $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/out123 \
	    $(1)/opt/bin
endef

$(eval $(call BuildPackage,libmpg123))
$(eval $(call BuildPackage,mpg123))
