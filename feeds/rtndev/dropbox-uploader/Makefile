#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dropbox-uploader
PKG_VERSION:=0.11.9-20130708
PKG_RELEASE:=1

PKG_REV:=b805522e80d8c1abe4996259ce897f24def75c7f
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/andreafabrizi/Dropbox-Uploader.git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/dropbox-uploader
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=File Transfer
	DEPENDS:=+bash +curl +sed +coreutils-basename +coreutils-date \
	    +coreutils-stat +coreutils-dd +coreutils-printf +coreutils-mkdir
	TITLE:=BASH script for Dropbox
	URL:=https://github.com/andreafabrizi/Dropbox-Uploader
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/dropbox-uploader/description
 Dropbox Uploader is a BASH script which can be used to upload, download, 
 delete or list files from Dropbox, an online file sharing, synchronization and backup service.
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/dropbox-uploader/install
	$(INSTALL_DIR) $(1)/opt/{bin,etc,tmp}
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dropbox_uploader.sh $(1)/opt/bin/dropbox_uploader
endef

$(eval $(call BuildPackage,dropbox-uploader))
