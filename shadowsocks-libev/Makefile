#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Original Makefile taken from https://github.com/madeye/shadowsocks-libev/blob/master/openwrt/Makefile

include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocks-libev
PKG_VERSION:=1.4.7
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE_URL:=https://github.com/madeye/shadowsocks-libev/archive
PKG_SOURCE:=v$(PKG_VERSION).tar.gz

PKG_INSTALL:=1
PKG_FIXUP:=libtool autoreconf

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks-libev/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	DEPENDS:=+libev +libpthread
	TITLE:=lightweight Socks5 proxy
	URL:=https://github.com/madeye/shadowsocks-libev
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/shadowsocks-libev
	$(call Package/shadowsocks-libev/Default)
	TITLE+= (OpenSSL)
	VARIANT:=openssl
	DEPENDS+= +libopenssl
endef

define Package/shadowsocks-libev-polarssl
	$(call Package/shadowsocks-libev/Default)
	TITLE+= (PolarSSL)
	VARIANT:=polarssl
	DEPENDS+= +libpolarssl
endef

define Package/shadowsocks-libev/description
 Shadowsocks-libev is a lightweight secured scoks5 proxy for embedded devices and low end boxes.
endef

Package/shadowsocks-libev-polarssl/description=$(Package/shadowsocks-libev/description)

define Package/shadowsocks-libev/conffiles
/opt/etc/shadowsocks.json
endef

ifeq ($(BUILD_VARIANT),polarssl)
CONFIGURE_ARGS += --with-crypto-library=polarssl
endif

TARGET_LDFLAGS += -lev -L$(STAGING_DIR)/opt/lib/libev
TARGET_CFLAGS += -I$(STAGING_DIR)/opt/include/libev

define Package/shadowsocks-libev/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_CONF) ./files/shadowsocks.json $(1)/opt/etc
	$(INSTALL_BIN) ./files/S22shadowsocks $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ss-{local,redir,server,tunnel} $(1)/opt/bin
endef

Package/shadowsocks-libev-polarssl/install=$(Package/shadowsocks-libev/install)

$(eval $(call BuildPackage,shadowsocks-libev))
$(eval $(call BuildPackage,shadowsocks-libev-polarssl))
