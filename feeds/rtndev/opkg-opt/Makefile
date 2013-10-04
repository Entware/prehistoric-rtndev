#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=opkg-opt
PKG_VERSION:=0.1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/opkg-opt
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+opkg +uclibc-opt
	TITLE:=provides Entware deployment with built-in ipkg.sh
	URL:=http://wl500g-repo.googlecode.com
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/opkg-opt/description
 opkg-opt is a metapackage to install Entware repo with ipkg.sh script with
 some firmwares.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/opkg-opt/install
	$(INSTALL_DIR) $(1)/opt/tmp $(1)/opt/var/{log,run}
	touch $(1)/opt/tmp/.opkg-opt-placeholder
endef

$(eval $(call BuildPackage,opkg-opt))
