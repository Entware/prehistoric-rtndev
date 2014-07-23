#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#


include $(TOPDIR)/rules.mk

PKG_NAME:=python-onedrive
PKG_VERSION:=14.06.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://pypi.python.org/packages/source/p/$(PKG_NAME)/
PKG_MD5SUM:=c6b09659fdf1d58b8241428014810bc2

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

#PKG_BUILD_DEPENDS:=python distribute/host

define Package/$(PKG_NAME)
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=Python and CLI interface to MS OneDrive REST API v5.0
	URL:=https://github.com/mk-fg/python-onedrive
	DEPENDS:=+python +python-requests +pyyaml +python-chardet +python-openssl
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/$(PKG_NAME)/description
 Python and command-line interface for Microsoft LiveConnect OneDrive
 REST API v5.0.
endef

define Package/$(PKG_NAME)/conffiles
/opt/etc/.lcrc
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/opt --root=$(PKG_INSTALL_DIR))
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
	    $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
	    $(1)$(PYTHON_PKG_DIR)/
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/onedrive/cli_tool.py $(1)/opt/bin/onedrive-cli
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
