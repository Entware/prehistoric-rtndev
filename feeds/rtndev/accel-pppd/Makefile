#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=accel-pppd
PKG_VERSION:=1.7.1
PKG_RELEASE:=1

PKG_SOURCE:=accel-ppp-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/accel-ppp
PKG_MDSUM:=3d80c8505f864a2a4a3e9ae584e0f28d
PKG_INSTALL:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/accel-ppp-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/accel-pppd
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	DEPENDS:=+libopenssl +libpcre +libpthread +librt
	TITLE:=accel-pppd VPN server
	URL:=http://sourceforge.net/apps/trac/accel-ppp/wiki
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/accel-pppd/description
 The ACCEL-PPTP is completly new implementation of PPTP/PPPoE/L2TP which was
 written from null. Userspace daemon has its own PPP implementation, so it
 does not uses pppd and one process (multi-threaded) manages all connections.
endef

define Build/Configure
	cd $(PKG_BUILD_DIR) && TARGET_OPENWRT=1 \
	AR="$(TARGET_CROSS)ar" \
	AS="$(TARGET_CC) -c $(TARGET_CFLAGS)" \
	LD="$(TARGET_CROSS)ld" \
	NM="$(TARGET_CROSS)nm" \
	CC="$(TARGET_CC)" \
	GCC="$(TARGET_CC)" \
	CXX="$(TARGET_CROSS)g++" \
	RANLIB="$(TARGET_CROSS)ranlib" \
	STRIP="$(TARGET_CROSS)strip" \
	OBJCOPY="$(TARGET_CROSS)objcopy" \
	OBJDUMP="$(TARGET_CROSS)objdump" \
	TARGET_CPPFLAGS="$(TARGET_CPPFLAGS)" \
	TARGET_CFLAGS="$(TARGET_CFLAGS)" \
	TARGET_LDFLAGS="$(TARGET_LDFLAGS)" \
	LIBS="$(STAGING_DIR)/opt/lib/)" \
	cmake \
		-DBUILD_DRIVER=FALSE \
		-DCMAKE_INSTALL_PREFIX=/opt \
		-DLOG_PGSQL=FALSE \
		-DRADIUS=FALSE \
		-DNETSNMP=FALSE \
		-DLOG_FILE=FALSE
endef

define Package/accel-pppd/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/accel-pppd $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/lib/accel-ppp
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/lib/accel-ppp/lib*.so \
		$(1)/opt/lib/accel-ppp
	$(INSTALL_DIR) $(1)/opt/share/accel-ppp/l2tp
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/accel-ppp/l2tp/dictionary{,.rfc2661,.rfc3931} \
		$(1)/opt/share/accel-ppp/l2tp
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/accel-ppp.conf.dist $(1)/opt/etc
endef

$(eval $(call BuildPackage,accel-pppd))
