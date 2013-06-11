#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uqmi
PKG_VERSION:=20130510
PKG_REV:=ab2b11f053aa767ff002935878ebfa9750a996e4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=git://nbd.name/uqmi.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/uqmi
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+libblobmsg-json
	TITLE:=standalone QMI utility
	URL:=http://nbd.name/gitweb.cgi?p=uqmi.git
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/uqmi/description
 uqmi is a small QMI utility
endef

CMAKE_OPTIONS += \
	-DOPTIONAL_INCLUDE_DIR=$(STAGING_DIR)/opt/include \

define Package/uqmi/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/uqmi $(1)/opt/sbin
endef

$(eval $(call BuildPackage,uqmi))
