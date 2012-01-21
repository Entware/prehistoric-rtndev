#
# Copyright (C) 2007-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=findutils
PKG_VERSION:=4.5.10
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).orig.tar.gz
PKG_SOURCE_URL:=http://ftp.debian.org/debian/pool/main/f/findutils
PKG_MD5SUM:=06bd1e0c0026e134c591c07de83dd94b
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/findutils
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=File finding utilities
  URL:=$(PKG_SOURCE_URL)
endef

define Package/findutils/description
	GNU Find Utilities are the basic directory searching utilities of the GNU operating system
endef


define Package/findutils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/find $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/xargs $(1)/opt/bin/
endef

$(eval $(call BuildPackage,findutils))

