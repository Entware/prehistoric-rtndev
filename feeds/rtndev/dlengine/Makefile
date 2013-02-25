#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Thanks to Megarem @ wl500g.info
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
	TITLE:=Download Engine
	URL:=http://wl500g.info/showthread.php?9947-Download-Engine-2-0-%F1%EA%F0%E8%EF%F2-%E4%EB%FF-%E7%E0%E3%F0%F3%E7%EA%E8-%F4%E0%E9%EB%EE%E2-(%F1-%EF%EE%E4%E4%E5%F0%E6%EA%EE%E9-%F4%E0%E9%EB%EE%EE%E1%EC%E5%ED%ED%E8%EA%EE%E2)
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/dlengine/description
 Download script (with file sharing sites support).
endef

define Package/dlengine/conffiles
/opt/etc/dlengine.conf
endef

define Build/Compile
endef

define Package/dlengine/install
	$(CP) ./files/* $(1)
endef

$(eval $(call BuildPackage,dlengine))
