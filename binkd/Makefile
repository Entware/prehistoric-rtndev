#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=binkd
PKG_VERSION:=1.1a-26
PKG_REV:=bbe5331d4b9b901677acb5dce0fb85f06da54ef8
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/green525/binkd
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/binkd
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=FTN
	DEPENDS:=+zlib +libbz2
	TITLE:=transfers files between two Fidonet systems over TCP/IP
	URL:=$(PKG_SOURCE_URL)
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/binkd/description
 Binkd is a Fidonet mailer designed to operate via TCP/IP networks.
 As a FTN-compatible internet daemon, it makes possible efficient utilization
 of TCP/IP protocol suite as a transport layer in FTN-based networks.
endef

define Package/binkd/conffiles
/opt/etc/binkd/binkd.conf
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) $(PKG_BUILD_DIR)/mkfls/unix/* $(PKG_BUILD_DIR)
endef

define Package/binkd/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/binkd $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/binkd.conf $(1)/opt/etc/binkd.conf
endef

$(eval $(call BuildPackage,binkd))
