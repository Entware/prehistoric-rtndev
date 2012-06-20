#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Original Makefile taken from here https://sites.google.com/site/fidonetbe/home/software/binkdopenwrt
#

include $(TOPDIR)/rules.mk

PKG_NAME:=golded-plus
PKG_VERSION:=115-20110223
PKG_RELEASE:=1

PKG_SOURCE:=gps$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/golded-plus/Golded%2B%201.1.5%20snapshots
PKG_MD5SUM:=6a1d63e7a39ced6e9907e2c8b8e1e666

include $(INCLUDE_DIR)/package.mk

PKG_UNPACK:=bzip2 -c -d $(DL_DIR)/$(PKG_SOURCE) | $(TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xf -

define Package/golded-plus
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=FTN
	DEPENDS:=+libncursesw +libstdcpp
	TITLE:=GoldED Plus FTN Editor
	URL:=http://golded-plus.sourceforge.net
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/golded-plus/description
	GoldED+ is a offline message reader for Fidonet and Usenet.
	This package contains only binaries without any configs.
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) $(PKG_BUILD_DIR)/golded3/mygolded.__h $(PKG_BUILD_DIR)/golded3/mygolded.h
endef

MAKE_FLAGS += \
	WIDE_NCURSES=1 \
	PLATFORM=lnx

MAKE_VARS += \
	LNKFLAGS="$(TARGET_LDFLAGS) -Wl,-rpath-link=$(STAGING_DIR)/opt/lib"

TARGET_CFLAGS += \
	-I$(STAGING_DIR)/opt/include/ncursesw

define Package/golded-plus/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/{gedlnx,gnlnx,rddtlnx} $(1)/opt/sbin
endef

$(eval $(call BuildPackage,golded-plus))
