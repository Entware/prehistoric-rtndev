#
# Copyright (C) 2006-2009 OpenWrt.org
# Copyright (C) 2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# This package was orphaned in OpenWRT trunk, r32110

include $(TOPDIR)/rules.mk

PKG_NAME:=palantir
PKG_VERSION:=2.8pre3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-server-20120509.tgz
PKG_SOURCE_URL:=http://www.fastpath.it/products/palantir/pub/
PKG_MD5SUM:=294346b92cd02b67c4cbe9a6354e34b5

#PKG_BUILD_DEPENDS:=libjpeg

define Package/palantir
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:=+libjpeg-turbo +libpthread
  TITLE:=A multichannel interactive streaming solution
  URL:=http://www.fastpath.it/products/palantir/
endef

define Package/palantir/description
	Palantir is a Linux-based streaming system designed to transmit live
	video, audio and data over a TCP/IP network, as well as to control
	remote devices.
endef

define Package/palantir/conffiles
/opt/etc/palantir.conf
endef

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-server-20120509

include $(INCLUDE_DIR)/package.mk

export CPPFLAGS=$(TARGET_CPPFLAGS)
export LDFLAGS=$(TARGET_LDFLAGS)

define Build/Compile	
	$(MAKE) -C $(PKG_BUILD_DIR)/server/libgsm \
		$(TARGET_CONFIGURE_OPTS) \
		CCINC="$(TARGET_CPPFLAGS)" \
		COPTS="$(TARGET_CFLAGS)" \
		lib/libgsm.a
	$(MAKE) -C $(PKG_BUILD_DIR)/server \
		$(TARGET_CONFIGURE_OPTS) \
		COPTS="$(TARGET_CFLAGS)" \
		palantir
endef

define Package/palantir/install	
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/server/palantir-mips.conf.sample $(1)/opt/etc/palantir.conf
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/server/palantir $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,palantir))
