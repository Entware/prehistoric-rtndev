#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rntrack
PKG_VERSION:=1.32
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-1_32-src.tar.bz2
PKG_SOURCE_URL:=@SF/project/ftrack-as/RNtrack/$(PKG_VERSION)
PKG_MD5SUM:=b34eff2443efe378d14d8c77c531d2e1

PKG_BUILD_DIR:=$(BUILD_DIR)/ftrack-as

include $(INCLUDE_DIR)/package.mk

define Package/rntrack
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=FTN
	DEPENDS:=+libstdcpp
	TITLE:=A FTN Messages tracker
	URL:=http://sourceforge.net/projects/ftrack-as
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/rntrack/description
 It\'s purpose is to process netmail on netmail hubs, though it can be useful
 for an ordinary node. It parses PKTs or message bases, compares messages
 with patterns and does a specified action if a pattern is matched. With some
 limitations RNTrack may also be used for echomail.
endef

define Package/rntrack/conffiles
/opt/etc/rntrack/rntrack.cfg
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/MakeFiles/linux \
		CONFIG="/opt/etc/rntrack/rntrack.cfg" \
		ENABLE_SCRIPTS=0 \
		ENABLE_LOG_PID=1 \
		ENABLE_SYSLOG_LOG_FORMAT=1 \
		CC="$(TARGET_CC)" \
		LDFLAGS="$(TARGET_LDFLAGS) -lstdc++" \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		LIB="$(TARGET_CROSS)ar" \
		RANLIB="$(TARGET_CROSS)ranlib"
endef

define Package/rntrack/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/MakeFiles/linux/rntrack $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/rntrack/tpl
	$(CP) $(PKG_BUILD_DIR)/samples/* $(1)/opt/etc/rntrack
endef

$(eval $(call BuildPackage,rntrack))
