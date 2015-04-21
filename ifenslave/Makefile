#
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ifenslave
PKG_VERSION:=2.6.22
PKG_RELEASE:=1
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/ifenslave
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A utility to manipulate kernel ethernet bonding devices
  URL:=http://www.kernel.org
endef

define Package/ifenslave/description
 ifenslave is needed to add/remove interfaces to/from ethernet bond devices.
endef

define Build/Prepare
endef

define Build/Compile
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) -o $(PKG_BUILD_DIR)/ifenslave \
		$(LINUX_DIR)/Documentation/networking/ifenslave.c
endef

define Package/ifenslave/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ifenslave $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,ifenslave))
