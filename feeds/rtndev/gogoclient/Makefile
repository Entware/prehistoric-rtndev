#
# Copyright (C) 2007-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gogoclient
PKG_VERSION:=6.0.1
PKG_RELEASE:=1

PKG_SOURCE:=gw6c-6_0-RELEASE-src.tar
PKG_SOURCE_URL:=http://ipv6now.com.au/download
PKG_MD5SUM:=0851184a08605e0a2b7395899e55c433

PKG_BUILD_DIR:=$(BUILD_DIR)/gw6c-6_0_1

include $(INCLUDE_DIR)/package.mk

define Package/gogoclient
  SECTION:=ipv6
  CATEGORY:=IPv6
  TITLE:=GOGO Gateway6 Client
  URL:=http://ipv6now.com.au/downloads.php
  DEPENDS:=+libopenssl +libpthread +libstdcpp
endef

define Package/gogoclient/description
	The Gateway6 Client is used on the host computer to connect 
	to a tunnel broker using the TSP protocol and to get the information 
	for its tunnel. When it receives the information for the tunnel, the 
	Gateway6 client creates the static tunnel
endef

define Build/Compile
	$(call Build/Compile/Default,\
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		EXTRA_CXXFLAGS="$(TARGET_CFLAGS)" \
		EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
		platform=linux \
		installdir=$(PKG_INSTALL_DIR)/opt \
		all install\
	)
endef

define Package/gogoclient/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/gw6c $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/share/gw6c/template
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/template/linux.sh $(1)/opt/share/gw6c/template
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DATA) ./files/gw6c.conf $(1)/opt/etc/
	$(INSTALL_DIR) $(1)/opt/var/log
endef

define Package/gogoclient/conffiles
/opt/etc/gw6c.conf
endef

$(eval $(call BuildPackage,gogoclient))
