#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libotr
PKG_VERSION:=3.2.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.cypherpunks.ca/otr/
PKG_MD5SUM:=faba02e60f64e492838929be2272f839

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libotr
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+libgpg-error +libgcrypt
	TITLE:=Off-the-Record (OTR) Messaging library
	URL:=http://http://www.cypherpunks.ca/otr/
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/libotr/description
  Off-the-Record (OTR) Messaging allows you to have private conversations over 
  instant messaging by providing encryption, authentication, deniability and
  perfect forward secrecy
endef

CONFIGURE_ARGS += \
        --prefix=/opt \

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/libotr
	$(CP) $(PKG_INSTALL_DIR)/opt/include/libotr/*.h $(1)/opt/include/libotr
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libotr.{a,la,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libotr.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libotr/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libotr.so* $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin
endef

$(eval $(call BuildPackage,libotr))
