#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Thanks to N0SF3R@TU @ ganjanetwork.ru for his URL support.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=golded-nsf
PKG_VERSION:=003
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=:pserver:anonymous@golded-plus.cvs.sourceforge.net:/cvsroot/golded-plus
PKG_SOURCE_SUBDIR:=golded+
PKG_SOURCE_VERSION:=-D'07/10/2009'
PKG_SOURCE_PROTO:=cvs

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

include $(INCLUDE_DIR)/package.mk

define Package/golded-nsf
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=FTN
	DEPENDS:=+libncurses +libpcrecpp +screen
	TITLE:=GoldEd-NSF FTN Editor
	URL:=http://fghi.pp.ru/golded
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/golded-nsf/description
 GoldEd-NSF is a offline message reader for Fidonet and Usenet. Its a successor
 of GoldEd+ with hypertext support and other usefull features.
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) $(PKG_BUILD_DIR)/golded3/mygolded.__h $(PKG_BUILD_DIR)/golded3/mygolded.h
endef

MAKE_FLAGS += \
	WIDE_NCURSES=1 \
	PLATFORM=lnx

MAKE_VARS += \
	LNKFLAGS="$(TARGET_LDFLAGS) -lpcrecpp"

TARGET_CFLAGS += \
	-I$(STAGING_DIR)/opt/include/ncursesw

define Package/golded-nsf/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/{gedlnx,gnlnx,rddtlnx} $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/golded\+/map
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/chsgen/map/* $(1)/opt/etc/golded\+/map
	$(INSTALL_DIR) $(1)/opt/etc/golded\+/cfgs
	$(CP) $(PKG_BUILD_DIR)/cfgs/* $(1)/opt/etc/golded\+/cfgs
	$(INSTALL_CONF) ./files/* $(1)/opt/etc/golded\+
endef

$(eval $(call BuildPackage,golded-nsf))
