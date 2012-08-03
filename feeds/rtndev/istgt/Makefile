#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=istgt
PKG_VERSION:=20120726
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://shell.peach.ne.jp/~aoyama/wordpress/download
PKG_MD5SUM:=22bf014d65f6412e41a7480a837c2b4e

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/istgt
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Filesystem
	DEPENDS:=+libopenssl +libpthread
	TITLE:=An iSCSI target implementation
	URL:=http://savannah.nongnu.org/projects/istgt
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/istgt/description
 This is a BSD Port of istgt, which  provides iSCSI target side protocol
 (refer to RFC3720 about iSCSI) and SPC-3 (SCSI Primary Commands - 3)
 based logical unit emulation.
endef

CONFIGURE_ARGS += \
	--with-mediadir=/opt/var \

define Package/istgt/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/istgt $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/istgtcontrol $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/istgt
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/istgt/{auth,istgt,istgt.large,istgtcontrol}.conf.sample $(1)/opt/etc/istgt
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S13istgt $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,istgt))
