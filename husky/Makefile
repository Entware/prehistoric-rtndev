#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=husky
PKG_VERSION:=1.9-20140519
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-all-1.9-source-20140519.tgz
PKG_SOURCE_URL:=@SF/husky/husky/1.9-current/2014.05.19
PKG_MD5SUM:=8c5f0a4b8971d4f9e0e872befb348826

include $(INCLUDE_DIR)/package.mk

PKG_UNPACK:=gzip -dc $(DL_DIR)/$(PKG_SOURCE) | $(TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xf -

define Package/husky
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=FTN
	TITLE:=HUSKY is a portable fidosoft project
	URL:=http://husky.sourceforge.net
	MAINTAINER:=Entware team, entware.wl500g.info
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

define Build/Configure
	$(CP) ./files/Makefile $(PKG_BUILD_DIR)
	$(CP) $(PKG_BUILD_DIR)/huskybse/huskymak.cfg $(PKG_BUILD_DIR)
	$(SED) 's|^\(PREFIX\)=.*|\1=\$(PKG_INSTALL_DIR)/opt|g' \
		$(PKG_BUILD_DIR)/huskymak.cfg
	$(SED) 's|^\(OPTLFLAGS\)=.*|\1=-s $(TARGET_LDFLAGS)|g' \
		$(PKG_BUILD_DIR)/huskymak.cfg
endef

define Package/husky/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/sbin
endef

$(eval $(call BuildPackage,husky))
