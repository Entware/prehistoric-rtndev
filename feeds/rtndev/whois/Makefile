#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=whois
PKG_VERSION:=5.0.10
PKG_RELEASE:=1

PKG_SOURCE:=whois_$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.debian.org/debian/pool/main/w/whois
PKG_MD5SUM:=d7626a3f789da85e70e4b931b6b34a26
PKG_CAT:=zcat
PKG_BUILD_DIR:=$(BUILD_DIR)/whois-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/whois
	SECTION:=net
	CATEGORY:=Network
	TITLE:=WHOIS commandline utility
	URL:=http://ftp.debian.org/debian/pool/main/w/whois
endef

define Package/whois/description
  Utility to display information from WHOIS servers
endef

define Package/whois/conffiles
/opt/etc/whois.conf
endef


define Package/whois/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/whois $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/whois.conf $(1)/opt/etc/whois.conf

endef

$(eval $(call BuildPackage,whois))
