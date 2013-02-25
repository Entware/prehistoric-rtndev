#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=husky
PKG_VERSION:=1.9
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-all-$(PKG_VERSION)-source-20110312.tgz
PKG_SOURCE_URL:=@SF/husky/husky/$(PKG_VERSION)-current/
PKG_MD5SUM:=f1e2f1087db82b38da83b594f2460b97

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/husky
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=FTN
	TITLE:=HUSKY is a portable fidosoft project
	URL:=http://husky.sourceforge.net
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/husky/description
 HUSKY is a portable fidosoft project, it includes HPT - a highly portable
 tosser and other FTN software. A package contains only binaries without any
 config files.
endef

TARGET_CFLAGS += \
	-I$(PKG_INSTALL_DIR)/opt/include

TARGET_LDFLAGS += \
	-L$(PKG_INSTALL_DIR)/opt/lib \
	-Wl,-rpath-link=$(PKG_INSTALL_DIR)/opt/lib

define Build/Compile
	$(CP) ./files/Makefile $(PKG_BUILD_DIR)
	$(CP) $(PKG_BUILD_DIR)/huskybse/huskymak.cfg $(PKG_BUILD_DIR)
	$(SED) 's|^PREFIX=/usr/local|PREFIX=$(PKG_INSTALL_DIR)/opt|g' \
		$(PKG_BUILD_DIR)/huskymak.cfg
	$(SED) 's|^LDCONFIG=/sbin/ldconfig||g' \
		$(PKG_BUILD_DIR)/huskymak.cfg
	$(SED) 's|^OPTIBOPT=-c -s -m 555|OPTIBOPT=-c -m 555|g' \
		$(PKG_BUILD_DIR)/huskymak.cfg
	$(SED) 's|^OPTLFLAGS=-s|OPTLFLAGS=-s $(TARGET_LDFLAGS)|g' \
		$(PKG_BUILD_DIR)/huskymak.cfg
	$(SED) 's|^MKSHARED=gcc |MKSHARED=gcc|g' \
		$(PKG_BUILD_DIR)/huskymak.cfg
	$(call Build/Compile/Default)
endef

define Package/husky/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/lib{areafix,fidoconfig,husky}.so{,.1.9,.1.9.0} \
		$(PKG_INSTALL_DIR)/opt/lib/libsmapi.so{,.2.5,.2.5.0} \
		$(1)/opt/lib
endef

$(eval $(call BuildPackage,husky))
