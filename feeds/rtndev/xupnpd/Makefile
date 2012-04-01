#
# Copyright (C) 2011 OpenWrt.org
# (c) http://www.zyxmon.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=xupnpd
PKG_REV:=301
PKG_VERSION:=$(PKG_REV)
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=svn
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=xupnpd-$(PKG_VERSION)
PKG_SOURCE_URL:=http://tsdemuxer.googlecode.com/svn/trunk/xupnpd/src/
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/xupnpd
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:=+liblua
  TITLE:=eXtensible UPnP agent
  URL:=http://xupnpd.org/
endef

define Package/xupnpd/conffiles
/opt/share/xupnpd/xupnpd.lua
endef

define Package/xupnpd/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/xupnpd $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/share/xupnpd
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/*.lua $(1)/opt/share/xupnpd
	$(INSTALL_DIR) $(1)/opt/share/xupnpd/ui
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ui/* $(1)/opt/share/xupnpd/ui
	$(INSTALL_DIR) $(1)/opt/share/xupnpd/www
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/* $(1)/opt/share/xupnpd/www
	$(INSTALL_DIR) $(1)/opt/share/xupnpd/plugins
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/plugins/* $(1)/opt/share/xupnpd/plugins
	$(INSTALL_DIR) $(1)/opt/share/xupnpd/config
	$(INSTALL_DIR) $(1)/opt/share/xupnpd/playlists
	$(CP) $(PKG_BUILD_DIR)/playlists/* $(1)/opt/share/xupnpd/playlists
	$(INSTALL_DIR) $(1)/opt/share/xupnpd/playlists/example
	$(CP) $(PKG_BUILD_DIR)/playlists/example/* $(1)/opt/share/xupnpd/playlists/example
endef

$(eval $(call BuildPackage,xupnpd))
