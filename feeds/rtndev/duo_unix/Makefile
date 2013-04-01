#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=duo_unix
PKG_VERSION:=1.9-20130305
PKG_RELEASE:=1

PKG_REV:=d5cd527c425ee0b26eb3d78131a65a2379e68aeb
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/duosecurity/duo_unix.git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/duo_unix/Default
	SECTION:=admin
	CATEGORY:=Administration
	DEPENDS:=+libopenssl +libssp
	TITLE:=two-factor authentication for Unix systems
	URL:=https://www.duosecurity.com/
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/libduo
	$(call Package/duo_unix/Default)
	TITLE+= (a resolver before dnscrypt-proxy start)
endef

define Package/duo_unix
	$(call Package/duo_unix/Default)
	DEPENDS+= +libduo
endef

define Package/libduo/description
 A library for two-factor authentication as a Duo:Security service
endef

define Package/duo_unix/description
 Provides simple two-factor authentication as a Duo:Security service
endef

#CONFIGURE_ARGS += \
#	--with-pam
# libpam is marked as @BROKEN for now

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/duo.h $(1)/opt/include
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libduo.{a,la,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/libduo.pc $(1)/opt/lib/pkgconfig
endef

define Package/libduo/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libduo.so* $(1)/opt/lib
endef

define Package/duo_unix/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/login_duo $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/login_duo.conf $(1)/opt/etc
endef

$(eval $(call BuildPackage,libduo))
$(eval $(call BuildPackage,duo_unix))
