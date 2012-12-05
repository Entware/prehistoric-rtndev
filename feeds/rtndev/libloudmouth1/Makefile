#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libloudmouth1
PKG_VERSION:=1.5.0-20121201
PKG_RELEASE:=1

PKG_SOURCE:=loudmouth-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://mcabber.com/files/
PKG_MD5SUM:=c03025069d376049eee8af4fbaf4d9cf
PKG_BUILD_DIR:=$(BUILD_DIR)/loudmouth-$(PKG_VERSION)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/libloudmouth1
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+libgnutls +glib2 +libidn
	TITLE:=Lightweight C Jabber library
	URL:=http://mcabber.com
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/libloudmouth1/description
  Loudmouth is a lightweight and easy-to-use C library for programming with the
  Jabber protocol. It's designed to be easy to get started with and yet
  extensible to let you do anything the Jabber protocol allows.
endef

CONFIGURE_ARGS += \
	--with-compile-warnings=no

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/loudmouth-1.0/loudmouth
	$(CP) $(PKG_INSTALL_DIR)/opt/include/loudmouth-1.0/loudmouth/*.h $(1)/opt/include/loudmouth-1.0/loudmouth
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libloudmouth-1.{a,la,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/loudmouth-1.0.pc $(1)/opt/lib/pkgconfig/
endef

define Package/libloudmouth1/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/loudmouth/.libs/libloudmouth-1.so* $(1)/opt/lib
endef

$(eval $(call BuildPackage,libloudmouth1))
