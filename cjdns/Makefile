#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Reworked version of https://github.com/cjdelisle/cjdns-openwrt/blob/master/cjdns/Makefile

include $(TOPDIR)/rules.mk

PKG_NAME:=cjdns
PKG_VERSION:=0.5-20131009
PKG_REV:=fa15457db8d53e69e0b8af291c1d844978434c7b
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=git://github.com/cjdelisle/cjdns.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_BUILD_DEPENDS:=nacl

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/cjdns
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Routing and Redirection
	DEPENDS:=+libpthread
	TITLE:=Experimental self configuring routing protocol
	URL:=$(PKG_SOURCE_URL)
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/cjdns/description
 Cjdns implements an encrypted IPv6 network using public key cryptography
 for address allocation and a distributed hash table for routing.
endef

CMAKE_OPTIONS += \
	-DOPENWRT=1 \
	-DNO_CODESTYLE=1 \
	-DWITH_PIE=0 \
	-DHAVE_NACL=1 \
	-DNACL_INCLUDE_DIRS="$(STAGING_DIR)/opt/include/nacl"

define Package/cjdns/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/cjdroute2 $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,cjdns))
