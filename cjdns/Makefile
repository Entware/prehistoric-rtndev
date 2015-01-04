#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Reworked version of https://github.com/SeattleMeshnet/meshbox/blob/master/cjdns/Makefile
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cjdns
PKG_VERSION:=0.5-20141122
PKG_REV:=f176d2c0271d764412bd13c7adf7ea475fa25e0f
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/cjdelisle/cjdns
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/cjdns
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Routing and Redirection
	DEPENDS:=+librt
	TITLE:=Experimental self configuring routing protocol
	URL:=$(PKG_SOURCE_URL)
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/cjdns/description
 Cjdns implements an encrypted IPv6 network using public key cryptography
 for address allocation and a distributed hash table for routing.
endef

define Build/Compile
	(cd $(PKG_BUILD_DIR) && \
	CROSS="$(TARGET_CROSS)" \
	CC="$(TARGET_CC)" \
	AR="$(TARGET_AR)" \
	RANLIB="$(TARGET_RANLIB)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	SYSTEM="linux" \
	TARGET_ARCH="$(CONFIG_ARCH)" \
	Seccomp_NO=1 \
	./do)
endef

define Package/cjdns/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cjdroute $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/publictoip6 $(1)/opt/bin
endef

$(eval $(call BuildPackage,cjdns))
