#
# Copyright (C) 2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=hubicfuse
PKG_VERSION:=1.0.1-20150103
PKG_REV:=166cd62b5361316c2db2a4ee1fbed60be2a96e5d
PKG_RELEASE:=1


PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/TurboGit/hubicfuse
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/hubicfuse
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Filesystem
	DEPENDS:=+curl +libfuse +libjson-c +libxml2
	TITLE:=mounts Hubic's cloud files
	URL:=https://github.com/TurboGit/hubicfuse
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/hubicfuse/description
 HubicFuse is a FUSE application which provides access to Hubic's
 cloud files via a mount-point.
endef

define Package/hubicfuse/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/hubic{fuse,_token} $(1)/opt/bin
endef

$(eval $(call BuildPackage,hubicfuse))
