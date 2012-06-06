#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zebedee
PKG_VERSION:=2.5.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/$(PKG_NAME)/$(PKG_NAME)-src/$(PKG_VERSION)
PKG_MD5SUM:=8a25832efb563578e66a7aa4195bc8f3

include $(INCLUDE_DIR)/package.mk

define Package/zebedee
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  DEPENDS:=+zlib +bzip2 +libopenssl +libpthread
  TITLE:=Zebedee Secure Tunnel
  URL:=http://www.winton.org.uk/zebedee/
endef

define Package/zebedee/description
 Zebedee is a simple program to establish an encrypted, compressed “tunnel” 
 for TCP/IP or UDP data transfer between two systems.
endef

define Build/Compile
	$(call Build/Compile/Default,\
		OS="linux" \
		LIBS="$(TARGET_LDFLAGS) -lcrypto -lz -lbz2 -lpthread" \
		CFLAGS="$(TARGET_CFLAGS) -I. -I$(STAGING_DIR)/opt/include \
			-I$(STAGING_DIR)/opt/include/openssl -DHAVE_PTHREADS" \
		ROOTDIR="$(PKG_INSTALL_DIR)/opt" \
		zebedee \
        )
endef

define Package/zebedee/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/{zebedee,ftpgw.tcl} $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/share/zebedee
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/client{1.key,2.key,s.id} $(1)/opt/share/zebedee
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/server.{key,zbd} $(1)/opt/share/zebedee
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/vnc{server,viewer}.zbd $(1)/opt/share/zebedee
endef

$(eval $(call BuildPackage,zebedee))
