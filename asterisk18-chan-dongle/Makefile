#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk18-chan-dongle
PKG_REV=42
PKG_VERSION:=r$(PKG_REV)
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://asterisk-chan-dongle.googlecode.com/svn/trunk/
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=svn

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/asterisk18-chan-dongle
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Telephony
	DEPENDS:=+asterisk18 $(ICONV_DEPENDS) $(INTL_DEPENDS)
	TITLE:=Huawei UMTS 3G dongle support
	URL:=http://code.google.com/p/asterisk-chan-dongle
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/asterisk18-chan-dongle/description
 Asterisk channel driver for Huawei UMTS cards.
 This channel driver is in alpha stage.
endef

CONFIGURE_ARGS += \
	--with-asterisk=$(STAGING_DIR)/opt/include/asterisk-1.8/include

TARGET_CFLAGS += \
	-DLOW_MEMORY \
	-D_XOPEN_SOURCE=600 \
	-DHAVE_CONFIG_H \

MAKE_ARGS += \
	DESTDIR="$(PKG_INSTALL_DIR)" \

define Package/asterisk18-chan-dongle/conffiles
/opt/etc/asterisk/dongle.conf
endef

define Package/asterisk18-chan-dongle/install
	$(INSTALL_DIR) $(1)/opt/etc/asterisk
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/etc/dongle.conf $(1)/opt/etc/asterisk/
	$(INSTALL_DIR) $(1)/opt/lib/asterisk/modules
	$(CP) $(PKG_BUILD_DIR)/chan_dongle.so $(1)/opt/lib/asterisk/modules/
endef

$(eval $(call BuildPackage,asterisk18-chan-dongle))
