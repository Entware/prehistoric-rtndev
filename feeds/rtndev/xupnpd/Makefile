#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=xupnpd
PKG_REV:=383
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
	URL:=http://xupnpd.org
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/xupnpd/description
 This program is a light DLNA Media Server which provides ContentDirectory 1
 service for sharing IPTV unicast streams over local area network (with udpxy
 for multicast to HTTP unicast conversion). You can watch HDTV broadcasts
 (multicast or unicast) and listen Internet Radio in IP network
 without transcoding and PC.
endef

define Package/xupnpd/conffiles
/opt/share/xupnpd/xupnpd.lua
endef

define Package/xupnpd/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/xupnpd $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/share/xupnpd/{ui,www,plugins,config,playlists}
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/*.lua $(1)/opt/share/xupnpd
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ui/* $(1)/opt/share/xupnpd/ui
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/* $(1)/opt/share/xupnpd/www
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/plugins/*.lua $(1)/opt/share/xupnpd/plugins
	$(INSTALL_DIR) $(1)/opt/share/xupnpd/plugins/{skel,staff}
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/plugins/skel/*.lua $(1)/opt/share/xupnpd/plugins/skel
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/plugins/staff/*.lua $(1)/opt/share/xupnpd/plugins/staff
	$(CP) $(PKG_BUILD_DIR)/playlists/* $(1)/opt/share/xupnpd/playlists
	$(INSTALL_DIR) $(1)/opt/share/xupnpd/playlists/example
	$(CP) $(PKG_BUILD_DIR)/playlists/example/* $(1)/opt/share/xupnpd/playlists/example
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S94xupnpd $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,xupnpd))
