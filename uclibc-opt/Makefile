#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uclibc-opt
PKG_VERSION:=0.9.32
PKG_RELEASE:=5

include $(INCLUDE_DIR)/package.mk

define Package/uclibc-opt
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+libc +libgcc +libstdcpp +libpthread +librt +ldconfig +findutils
	TITLE:=provides basic uclibc libraries
	URL:=http://entware.wl500g.info
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/uclibc-opt/description
 uclibc-opt is a metapackage to install Entware basic libraries.
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
	$(INSTALL_BIN) ./files/profile $(1)/opt/etc/
	$(INSTALL_DATA) ./files/rc.func $(1)/opt/etc/init.d/
	touch $(1)/opt/etc/ld.so.conf
	$(INSTALL_DIR) $(1)/opt/usr/lib
endef

define Package/uclibc-opt/conffiles
/opt/etc/profile
endef

define Package/uclibc-opt/postinst
#!/bin/sh

echo -n "Updating /opt/etc/ld.so.cache... "
/opt/bin/ldconfig > /dev/null 2>&1
echo "done."
endef

$(eval $(call BuildPackage,uclibc-opt))
