#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=castget
PKG_VERSION:=1.1.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://savannah.nongnu.org/download/$(PKG_NAME)
PKG_MD5SUM:=e80096715efc17d1d87de793871e0006

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/castget
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=File Transfer
	DEPENDS:=+libcurl +glib2 +libxml2 $(ICONV_DEPENDS) $(INTL_DEPENDS)
	TITLE:=a command-line podcast downloader
	URL:=http://www.nongnu.org/castget
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/castget/description
 castget is a simple, command-line based RSS enclosure downloader.
 It is primarily intended for automatic, unattended downloading of podcasts.
endef

CONFIGURE_ARGS += \
	--disable-id3lib

define Package/castget/conffiles
/opt/etc/castgetrc
endef

define Package/castget/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/castget $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/castgetrc.example $(1)/opt/etc/castgetrc
endef

$(eval $(call BuildPackage,castget))
