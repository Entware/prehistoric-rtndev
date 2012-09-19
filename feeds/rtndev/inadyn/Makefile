#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=inadyn
PKG_VERSION:=1.99.2
PKG_RELEASE:=1

PKG_REV:=10e8ac6f7204ee3d5c6acbcc34f241291efeb41c
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/vampik/inadyn.git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/inadyn
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=a simple and small DDNS client
	URL:=https://github.com/vampik/inadyn
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/inadyn/description
 Inadyn is a simple and small DDNS client written in the C language. It can
 maintain multiple host names with the same IP address, and has a web based
 IP detection which runs well behind a NAT router. This is a fork by
 Andrey Tikhomirov.
endef

TARGET_CFLAGS += -Iinclude -DVERSION_STRING=\"$(VERSION)\"

define Package/inadyn/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/inadyn $(1)/opt/bin/
endef

$(eval $(call BuildPackage,inadyn))
