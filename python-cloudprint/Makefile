#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-cloudprint
PKG_VERSION:=0.11
PKG_RELEASE:=1

PKG_SOURCE:=cloudprint-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://pypi.python.org/packages/source/c/cloudprint
PKG_MD5SUM:=3990129390f4a1ddfa28767a3c293930

PKG_BUILD_DEPENDS:=distribute/host

PKG_BUILD_DIR:=$(BUILD_DIR)/cloudprint-$(PKG_VERSION)
include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-cloudprint
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	DEPENDS:=+python +python-cups
	TITLE:=Python bindings for the cloudprint API
	URL:=http://cyberelk.net/tim/software/pycloudprint/
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/python-cloudprint/description
 This is a Python bindings for the cloudprint API, known as pycloudprint. It was written
 for use with system-config-printer, but can be put to other uses as well.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/opt --root=$(PKG_INSTALL_DIR))
endef

define Package/python-cloudprint/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
	chmod +x $(1)$(PYTHON_PKG_DIR)/cloudprint/cloudprint.py
	$(INSTALL_DIR) $(1)/opt/{bin,var}
	ln -s $(PYTHON_PKG_DIR)/cloudprint/cloudprint.py $(1)/opt/bin/cloudprint
endef

$(eval $(call BuildPackage,python-cloudprint))
