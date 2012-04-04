#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-dropbox
PKG_VERSION:=1.4
PKG_RELEASE:=1

PKG_SOURCE:=dropbox-python-sdk-$(PKG_VERSION).zip
PKG_SOURCE_URL:=https://www.dropbox.com/static/developers
PKG_MD5SUM:=e8db82d88697951a0dfb887f1450c60a
PKG_BUILD_DEPENDS:=python
PKG_BUILD_DIR:=$(BUILD_DIR)/dropbox-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-dropbox
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Dropbox SDK for Python
  URL:=https://www.dropbox.com/developers/reference/sdk
  DEPENDS:=+python +distribute +python-oauth +simplejson +python-openssl
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
