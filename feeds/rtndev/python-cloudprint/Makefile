#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-cloudprint
PKG_VERSION:=0.5-20120602
PKG_RELEASE:=1

PKG_REV:=953a40070e559cf3ee798a388e155128520cf34a
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/armooo/cloudprint.git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_BUILD_DEPENDS:=distribute/host

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-cloudprint
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	DEPENDS:=+python +python-cups +python-openssl
	TITLE:=Python bindings for the cloudprint API
	URL:=http://cyberelk.net/tim/software/pycloudprint/
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
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
