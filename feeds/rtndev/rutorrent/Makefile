#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Thanks to AndreyUA @ wl500g.info
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rutorrent
PKG_REV:=2074
PKG_VERSION:=$(PKG_REV)
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=svn
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=rutorrent-$(PKG_VERSION)
PKG_SOURCE_URL:=http://rutorrent.googlecode.com/svn/trunk/
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/rutorrent/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=BitTorrent
	DEPENDS:=+rtorrent +php5-cgi +coreutils-stat +coreutils-id
	TITLE:=Yet another web front-end for rTorrent
	URL:=http://rutorrent.googlecode.com
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/rutorrent/Default/description
 ruTorrent is a front-end for the popular Bittorrent client rTorrent.
endef

define Package/rutorrent
$(call Package/rutorrent/Default)
endef

define Package/rutorrent/description
$(call Package/rutorrent/Default/description)
endef

define Package/rutorrent-plugins
$(call Package/rutorrent/Default)
	TITLE+= (plugins)
endef

define Package/rutorrent-plugins/description
$(call Package/rutorrent/Default/description)
	This package includes all avaliable plugins.
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/rutorrent/install
	$(INSTALL_DIR) $(1)/opt/share/www/rutorrent
	$(CP) $(PKG_BUILD_DIR)/rutorrent/* $(1)/opt/share/www/rutorrent/
endef

define Package/rutorrent-plugins/install
	$(INSTALL_DIR) $(1)/opt/share/www/rutorrent/plugins
	$(CP) $(PKG_BUILD_DIR)/plugins/* $(1)/opt/share/www/rutorrent/plugins/
endef

$(eval $(call BuildPackage,rutorrent))
$(eval $(call BuildPackage,rutorrent-plugins))
