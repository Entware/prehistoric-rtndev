#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nethogs
PKG_VERSION:=0.8.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/nethogs
PKG_MDSUM:=d6fb12b46e80a50c9b9f91dd48e2b234
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
#include $(INCLUDE_DIR)/cmake.mk

define Package/nethogs
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libncurses +libpcap +libstdcpp
	TITLE:=NetHogs is a small 'net top' tool
	URL:=http://nethogs.sourceforge.net/
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/nethogs/description
 NetHogs is a small 'net top' tool. Instead of breaking the traffic down per protocol 
 or per subnet, like most tools do, it groups bandwidth by process. NetHogs does not rely
 on a special kernel module to be loaded. If there's suddenly a lot of network traffic, 
 you can fire up NetHogs and immediately see which PID is causing this. This makes it easy 
 to indentify programs that have gone wild and are suddenly taking up your bandwidth.
endef

TARGET_CFLAGS += $(TARGET_CPPFLAGS) $(TARGET_LDFLAGS)
MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS)" \
	DESTDIR=/opt \

define Package/nethogs/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nethogs $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,nethogs))
