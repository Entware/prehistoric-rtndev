# 
# Copyright (C) 2009 OpenWrt.org
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# ipset4 was abandoned in OpenWRT trunk since r30895
# but we still have to use it as long as we on kernel 2.6.22.19

include $(TOPDIR)/rules.mk

PKG_NAME:=ipset4
PKG_VERSION:=4.5
PKG_RELEASE:=1

PKG_SOURCE:=ipset-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://ipset.netfilter.org
PKG_MD5SUM:=fafc5954083c877d3cedaff38b02754b

PKG_BUILD_DIR:=$(BUILD_DIR)/ipset-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/ipset4
	SECTION:=net
	CATEGORY:=Network
	TITLE:=IPset v4 administration utility
	URL:=http://ipset.netfilter.org/
	MAINTAINER:=Entware team, entware.wl500g.info
endef

IPSET_MAKEOPTS:= -C $(PKG_BUILD_DIR) \
	$(TARGET_CONFIGURE_OPTS) \
	COPT_FLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="-rdynamic $(TARGET_LDFLAGS)" \
	NO_EXTRA_WARN_FLAGS=yes \
	KERNEL_DIR="$(LINUX_DIR)" \
	PREFIX=/opt \

define Build/Compile
	mkdir -p $(PKG_INSTALL_DIR)
	$(MAKE) $(IPSET_MAKEOPTS) binaries
	$(MAKE) $(IPSET_MAKEOPTS) DESTDIR="$(PKG_INSTALL_DIR)" binaries_install
endef

define Package/ipset4/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/ipset $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/lib/ipset
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/ipset/libipset*.so $(1)/opt/lib/ipset/
endef

$(eval $(call BuildPackage,ipset4))
