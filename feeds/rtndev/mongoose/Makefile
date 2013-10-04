#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mongoose
PKG_VERSION:=3.8
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=https://mongoose.googlecode.com/files
PKG_MD5SUM:=7e3296295072792cdc3c633f9404e0c3

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/mongoose
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=easy to use web server
	DEPENDS:=+libpthread
	URL:=http://mongoose.googlecode.com
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/mongoose/description
 Easy to use, powerful, embeddable web server.
endef

MAKE_FLAGS += \
	linux \

TARGET_CFLAGS += \
	-DNDEBUG \

TARGET_LDFLAGS += \
	-lm \

define Package/mongoose/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mongoose $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/{init.d,mongoose}
	touch $(1)/opt/etc/put_delete.auth
	$(INSTALL_BIN) ./files/S80mongoose $(1)/opt/etc/init.d
	$(INSTALL_CONF) ./files/mongoose.conf $(1)/opt/etc/mongoose
	$(INSTALL_DIR) $(1)/opt/share/www $(1)/opt/var/log/mongoose
endef

$(eval $(call BuildPackage,mongoose))
