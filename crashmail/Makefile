#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Original Makefile taken from https://sites.google.com/site/fidonetbe/home/software/binkdopenwrt
#

include $(TOPDIR)/rules.mk

PKG_NAME:=crashmail
PKG_VERSION:=0.88
PKG_RELEASE:=1

PKG_REV:=26e5374710c7868dab3d834be14bf4041041aae5
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/larsks/crashmail
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/crashmail
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=FTN
	TITLE:=CrashMail II
	URL:=$(PKG_SOURCE_URL)
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/crashmail/description
 CrashMail II is basically a more portable version of CrashMail,
 a FidoNet tosser for Amiga computers.
endef

TARGET_CPPFLAGS += \
	-I$(PKG_BUILD_DIR) \

MAKE_FLAGS += \
	AR="$(TARGET_CROSS)ar -ru" \

define Package/crashmail/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/crashmail/crashmail \
		$(PKG_BUILD_DIR)/tools/crash{export,getnode,list,listout,maint,stats,write} \
		$(1)/opt/bin
endef

$(eval $(call BuildPackage,crashmail))
