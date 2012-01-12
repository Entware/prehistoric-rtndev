#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dlengine
PKG_VERSION:=2.0
PKG_RELEASE:=19

include $(INCLUDE_DIR)/package.mk

define Package/dlengine
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=File Transfer
  DEPENDS:=+bash +coreutils-mv +wget 
  TITLE:=Simple multi WAN configuration
  URL:=http://www.wl500g.info/showthread.php?t=9947
  MAINTAINER:=megarem@mail.ru
endef

define Package/dlengine/description
Download script (with file sharing sites support)
endef

define Package/dlengine/conffiles
/opt/etc/dlengine.conf
/opt/etc/httpd.conf
/opt/etc/init.d/S50dlengine
/opt/etc/init.d/S90busybox_httpd
endef

define Build/Compile
endef

define Package/dlengine/install
	$(CP) ./files/* $(1)
endef

$(eval $(call BuildPackage,dlengine))
