#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=accel-ppp
PKG_VERSION:=1.7.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/accel-ppp
PKG_MDSUM:=bf03f20d9df9a0694e5cd0be9b57d1b6

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/accel-ppp
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	DEPENDS:=+libopenssl +libpcre +libpthread +librt
	TITLE:=accel-ppp VPN server
	URL:=http://sourceforge.net/apps/trac/accel-ppp/wiki
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/accel-ppp/description
 The ACCEL-PPP is high performance PPTP/L2TP/PPPoE server for Linux. Userspace
 daemon has its own PPP implementation, so it does not uses pppd and one process
 (multi-threaded) manages all connections.
endef

CMAKE_OPTIONS += \
	-DBUILD_DRIVER=FALSE \
	-DCMAKE_INSTALL_PREFIX=/opt \
	-DCMAKE_BUILD_TYPE=Release \
	-DLOG_PGSQL=FALSE \
	-DSHAPER=FALSE \
	-DRADIUS=TRUE \
	-DNETSNMP=FALSE \
	-DLOG_FILE=FALSE \

TARGET_CFLAGS += \
	-I$(STAGING_DIR)/opt/include \

define Package/accel-ppp/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/accel-pppd $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/lib/accel-ppp
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/lib/accel-ppp/lib*.so \
		$(1)/opt/lib/accel-ppp
	$(INSTALL_DIR) $(1)/opt/share/accel-ppp/l2tp
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/accel-ppp/l2tp/dictionary* \
		$(1)/opt/share/accel-ppp/l2tp
	$(INSTALL_DIR) $(1)/opt/share/accel-ppp/radius
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/share/accel-ppp/radius/dictionary* \
		$(1)/opt/share/accel-ppp/radius
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/accel-ppp.conf.dist $(1)/opt/etc
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) files/S60accel-ppp $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,accel-ppp))
