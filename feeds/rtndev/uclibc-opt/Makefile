#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uclibc-opt
PKG_VERSION:=0.9.32
PKG_RELEASE:=2

include $(INCLUDE_DIR)/package.mk

define Package/uclibc-opt
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+libc +libgcc +libstdcpp +libpthread +librt +ldconfig +findutils
	TITLE:=uclibc-opt metapackage provides basic uclibc libraries
	URL:=http://uclibc.org
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/uclibc-opt/description
 uclibc-opt used to configure libraries search path to /opt/lib. Nothing more.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/uclibc-opt/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/rc.unslung $(1)/opt/etc/init.d/
	$(INSTALL_DATA) ./files/rc.func $(1)/opt/etc/init.d/
	touch $(1)/opt/etc/ld.so.conf
	$(INSTALL_DIR) $(1)/opt/usr/lib
endef

define Package/uclibc-opt/postinst
#!/bin/sh

echo "Updating /opt/etc/ld.so.cache"
/opt/bin/ldconfig
endef

$(eval $(call BuildPackage,uclibc-opt))
