#
# Copyright (C) 2007-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=findutils
PKG_VERSION:=4.5.14
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).orig.tar.gz
PKG_SOURCE_URL:=http://ftp.debian.org/debian/pool/main/f/findutils
PKG_MD5SUM:=a8a8176282fd28e8d1234c84d847fa66
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/findutils/Default
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=File finding utilities
	URL:=$(PKG_SOURCE_URL)
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/findutils
	$(call Package/findutils/Default)
endef

define Package/findutils-locate
	$(call Package/findutils/Default)
	TITLE+= (locate and relative utils)
	DEPENDS:=+findutils
endef

define Package/findutils/description
 GNU Find Utilities are the basic directory searching utilities of the GNU OS.
endef

define Package/findutils-locate/description
 locate, updatedb is a part of GNU Find Utilities.
endef

define Package/findutils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{find,xargs} \
	    $(1)/opt/bin/
endef

define Package/findutils-locate/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{locate,updatedb} \
	    $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/{bigram,code,frcode} \
	    $(1)/opt/lib/
endef

$(eval $(call BuildPackage,findutils))
$(eval $(call BuildPackage,findutils-locate))
