#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mathomatic
PKG_VERSION:=16.0.2
PKG_RELEASE:=1

PKG_SOURCE:=mathomatic-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://mathomatic.org
PKG_MD5SUM:=17d4034b9f4af59d55095d47e9096c7b

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/mathomatic
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+libreadline +libncurses
	TITLE:=Small computer algebra system.
	URL:=http://www.mathomatic.org/math/
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/mathomatic/description
 Mathomatic can symbolically solve, simplify, combine, and compare algebraic equations,
 simultaneously performing generalized standard, complex number, modular, and polynomial arithmetic, as needed.
endef

define Build/Configure
	$(call Build/Compile/Default, \
	prefix=/opt \
	READLINE=1 \
	LDLIBS="-lm -lreadline -lncurses" \
	HANDHELD=1 \
	)
endef

define Package/mathomatic/install
	$(INSTALL_DIR) $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mathomatic $(1)/opt/bin/
	#$(INSTALL_BIN) $(PKG_BUILD_DIR)/m4/rmath $(1)/opt/bin/
	#$(INSTALL_BIN) $(PKG_BUILD_DIR)/m4/functions.m4 $(1)/opt/bin/
	#$(INSTALL_BIN) $(PKG_BUILD_DIR)/m4/matho $(1)/opt/bin/
endef

$(eval $(call BuildPackage,mathomatic))
