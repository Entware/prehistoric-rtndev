#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=esniper
PKG_VERSION:=2.28.0
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-2-28-0.tgz
PKG_SOURCE_URL:=@SF/$(PKG_NAME)/$(PKG_NAME)/$(PKG_VERSION)
PKG_MDSUM:=edcd29e7c86adef67060f0cfbf698028

PKG_INSTALL:=1
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-2-28-0

include $(INCLUDE_DIR)/package.mk

define Package/esniper
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libcurl
	TITLE:=a lightweight tool for sniping ebay auctions
	URL:=http://esniper.sourceforge.net/
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/esniper/description
 esniper is a simple, lightweight tool for sniping ebay auctions.
endef

define Package/esniper/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/esniper $(1)/opt/bin/
endef

$(eval $(call BuildPackage,esniper))
