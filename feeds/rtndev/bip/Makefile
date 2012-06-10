#
# Copyright (C) 2006-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bip
PKG_VERSION:=0.8.8
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://projects.duckcorp.org/attachments/download/39
PKG_MD5SUM:=261d53ead8a35d08caa7dc0f76566b98

PKG_INSTALL:=1
PKG_FIXUP:=libtool

include $(INCLUDE_DIR)/package.mk

define Package/bip
  SUBMENU:=Instant Messaging
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libopenssl
  TITLE:=multi user irc proxy
  URL:=https://projects.duckcorp.org/projects/bip
endef

define Package/bip/description
  Bip is an IRC proxy, which means it keeps connected to your preferred
  IRC servers, can store the logs for you, and even send them back to your
  IRC client(s) upon connection.
endef

define Package/ziproxy/conffiles
/opt/etc/bip.conf
endef

define Package/bip/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{bip,bipmkpw} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/share/doc/bip/examples/bip.conf $(1)/opt/etc
	$(INSTALL_BIN) ./files/S99bip $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,bip))
