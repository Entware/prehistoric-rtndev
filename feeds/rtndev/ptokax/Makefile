#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ptokax
PKG_VERSION:=0.5.0.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_VERSION)-nix-src.tgz
PKG_SOURCE_URL:=http://www.czdc.org/PtokaX
PKG_MD5SUM:=3711a087fad483f4af015c829ea423c0

include $(INCLUDE_DIR)/package.mk

PKG_UNPACK=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/ptokax
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=P2P
	DEPENDS:=+liblua +libpthread +zlib +libstdcpp +librt
	TITLE:=DC hub
	URL:=http://www.czdc.org/PtokaX/
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/ptokax/description
 PtokaX Direct Connect Hub is a multi-platform server application
 for Neo-Modus Direct Connect Peer-To-Peer sharing network.
endef

define Download/files
 define Download/$(1)
  FILE:=$(2)
  URL:=$(4)
  MD5SUM:=$(3)
 endef
 $$(eval $$(call Download,$(1)))
endef

define Build/Configure
	$(call Build/Configure/Default)
	$(eval $(call Download/files,tinyxml,tinyxml_2_6_2.zip,2a0aaf609c9e670ec9748cd01ed52dae,@SF/tinyxml/tinyxml/2.6.2))
	unzip -d $(PKG_BUILD_DIR) $(DL_DIR)/tinyxml_2_6_2.zip tinyxml/tiny{str.h,xml.cpp,xmlerror.cpp,str.cpp,xml.h,xmlparser.cpp}
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR)/tinyxml $(MAKE_FLAGS)
	$(call Build/Compile/Default)
endef

define Package/ptokax/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/PtokaX $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S95ptokax $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/share/ptokax/cfg
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/cfg.example/*.xml $(1)/opt/share/ptokax/cfg
endef

$(eval $(call BuildPackage,ptokax))
