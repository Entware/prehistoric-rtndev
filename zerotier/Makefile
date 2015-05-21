#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zerotier
PKG_VERSION:=1.0.2
PKG_REV:=95e303d6f316e4a929d119a4255c79cca5a8a6e6
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/zerotier/ZeroTierOne
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/zerotier
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	DEPENDS:=+libstdcpp +libpthread
	TITLE:=Ethernet virtualization engine
	URL:=https://www.zerotier.com/
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/zerotier/description
 Create flat virtual Ethernet networks of almost unlimited size.
endef

define Package/zerotier/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/zerotier-one $(1)/opt/bin
	$(LN) zerotier-one $(1)/opt/bin/zerotier-cli
	$(LN) zerotier-one $(1)/opt/bin/zerotier-idtool
	$(INSTALL_DIR) $(1)/opt/var/lib/zerotier-one
endef

$(eval $(call BuildPackage,zerotier))
