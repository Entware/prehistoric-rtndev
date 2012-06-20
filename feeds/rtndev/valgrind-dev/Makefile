#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=valgrind-dev
PKG_VERSION:=3.6.1
PKG_RELEASE:=1

PKG_SOURCE:=valgrind_3.6.1_mipsel.ipk
PKG_SOURCE_URL:=http://wl500g.googlecode.com/svn/ipkg/optware-rtn/
PKG_MD5SUM:=c77d31683192fbe42ae1088227914765

include $(INCLUDE_DIR)/package.mk

PKG_UNPACK=tar -O -xf $(DL_DIR)/$(PKG_SOURCE) ./data.tar.gz | tar -xzC $(PKG_BUILD_DIR)

define Package/valgrind-dev
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=debugging and profiling Linux programs
	URL:=http://www.valgrind.org
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/valgrind-dev/description
 Valgrind is an award-winning suite of tools for debugging and profiling Linux
 programs. Binaries from 1.9.2.7-rtn firmware site.
 NB! MIPS32r2 platform only! Oleg's firmware only!
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/valgrind-dev/install
	$(INSTALL_DIR) $(1)/opt
	rm -rf $(PKG_BUILD_DIR)/opt/share
	$(CP) $(PKG_BUILD_DIR)/opt/* $(1)/opt
endef

$(eval $(call BuildPackage,valgrind-dev))
