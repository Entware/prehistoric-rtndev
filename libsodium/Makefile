#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libsodium
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.dnscrypt.org/libsodium/releases
PKG_MD5SUM:=3093dabe4e038d09f0d150cef064b2f7

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libsodium
	SECTION:=libs
	CATEGORY:=Libraries
	TITLE:=library for network communication, encryption, decryption, etc
	URL:=https://github.com/jedisct1/libsodium
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/libsodium/description
 A high-speed software library for network communication, encryption,
 decryption, signatures, etc.
endef

define Package/libsodium/config
menu "Configuration"
    config LIBSODIUM_MINIMAL
	bool "Create a smaller library"
	default n
endmenu
endef

TARGET_CFLAGS += \
	-std=gnu99 \

CONFIGURE_ARGS += \
	--disable-ssp \
	--disable-asm \
	$(if $(CONFIG_LIBSODIUM_MINIMAL),--enable-minimal=yes,--enable-minimal=no)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/sodium
	$(CP) $(PKG_INSTALL_DIR)/opt/include/*.h $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/sodium/*.h $(1)/opt/include/sodium
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsodium.{a,la,so*} $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libsodium.pc $(1)/opt/lib/pkgconfig
endef

define Package/libsodium/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsodium.so* $(1)/opt/lib
endef

$(eval $(call BuildPackage,libsodium))
