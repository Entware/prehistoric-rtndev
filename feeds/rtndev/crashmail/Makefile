#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Original Makefile taken from https://sites.google.com/site/fidonetbe/home/software/binkdopenwrt
#

include $(TOPDIR)/rules.mk

PKG_NAME:=crashmail
PKG_VERSION:=0.71
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/crashmail-$(PKG_VERSION)
PKG_SOURCE:=crashmail_$(PKG_VERSION).orig.tar.gz
PKG_SOURCE_URL:=http://ftp.de.debian.org/debian/pool/main/c/crashmail
PKG_MD5SUM:=8dbfa277fec07f477b67b6c7944432bb

include $(INCLUDE_DIR)/package.mk

define Package/crashmail
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=FTN
	TITLE:=CrashMail II
	URL:=http://packages.debian.org/ru/squeeze/crashmail
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/crashmail/description
 CrashMail II is basically a more portable version of CrashMail,
 a FidoNet tosser for Amiga computers.
endef

define Build/Compile
	mkdir -p  $(PKG_BUILD_DIR)/bin/
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR)/src \
		$(MAKE_FLAGS) linux
endef

define Package/crashmail/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/bin/crash{export,getnode,list,listout,mail,maint,stats,write} \
		$(1)/opt/bin
endef

$(eval $(call BuildPackage,crashmail))
