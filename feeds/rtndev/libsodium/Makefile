#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libsodium
PKG_VERSION:=0.4.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.dnscrypt.org/libsodium/releases
PKG_MD5SUM:=52fea92a73da837068f1faf30e31aa19

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libsodium
	SECTION:=libs
	CATEGORY:=Libraries
	TITLE:=library for network communication, encryption, decryption, etc
	URL:=https://github.com/jedisct1/libsodium
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/libsodium/description
 A high-speed software library for network communication, encryption,
 decryption, signatures, etc.
endef

TARGET_CFLAGS += \
	-std=gnu99 \

CONFIGURE_ARGS += \
	--disable-ssp \

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/sodium
	$(CP) $(PKG_INSTALL_DIR)/opt/include/*.h $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/sodium/*.h $(1)/opt/include/sodium
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsodium.{a,la,so*} $(1)/opt/lib/
endef

define Package/libsodium/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libsodium.so* $(1)/opt/lib
endef

$(eval $(call BuildPackage,libsodium))
