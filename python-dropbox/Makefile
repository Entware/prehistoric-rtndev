#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-dropbox
PKG_VERSION:=2.2.0
PKG_RELEASE:=1

PKG_SOURCE:=dropbox-python-sdk-$(PKG_VERSION).zip
PKG_SOURCE_URL:=https://www.dropbox.com/developers/downloads/sdks/datastore/python
PKG_MD5SUM:=582d5558fe5dca026db32e20f81c8cc5
PKG_BUILD_DEPENDS:=python
PKG_BUILD_DIR:=$(BUILD_DIR)/dropbox-python-sdk-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-dropbox
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	DEPENDS:=+python +distribute +python-oauth +simplejson +python-openssl
	TITLE:=Dropbox SDK for Python
	URL:=https://www.dropbox.com/developers/reference/sdk
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/python-dropbox/description
 The SDKs contain platform-specific libraries that wrap the raw HTTP calls
 to the Dropbox API. They are designed to shorten the distance between
 your application and integrating Dropbox.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/opt --root=$(PKG_INSTALL_DIR))
endef

define Package/python-dropbox/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-dropbox))
