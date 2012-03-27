#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uclibc-opt
PKG_VERSION:=0.9.32
PKG_RELEASE:=1

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=http://uclibc-opt.ru/download

include $(INCLUDE_DIR)/package.mk

define Package/uclibc-opt
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+libc +libgcc +libstdcpp +libpthread +librt +ldconfig
	TITLE:=uclibc-opt metapackage provides basic uclibc libraries
	URL:=http://uclibc.org/
endef

define Package/uclibc-opt/description
	uclibc-opt used to configure libraries search path to /opt/lib. Nothing more.
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/uclibc-opt/install
	$(INSTALL_DIR) $(1)/opt/etc
	touch $(1)/opt/etc/ld.so.conf
	$(INSTALL_DIR) $(1)/opt/usr/lib
endef

define Package/uclibc-opt/postinst
#!/bin/sh

echo "Updating /opt/etc/ld.so.cache"
/opt/bin/ldconfig
endef

$(eval $(call BuildPackage,uclibc-opt))