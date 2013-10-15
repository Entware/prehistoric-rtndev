#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=weave-minimal
PKG_VERSION:=1.2
PKG_RELEASE:=1

PKG_REV:=437bda296ef319365e398fff09f367e0284568ef
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/posativ/weave-minimal.git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_BUILD_DEPENDS:=distribute/host

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/weave-minimal
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+python-sqlite3 +python-werkzeug +distribute +dtach
	TITLE:=a Firefox Sync Server
	URL:=https://github.com/posativ/weave-minimal
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/weave-minimal/description
 This is a lightweight implementation of Mozilla User API v1.0 and Storage
 API v1.1 without LDAP, MySQL, Redis etc. overhead.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/opt --root=$(PKG_INSTALL_DIR))
endef

define Package/weave-minimal/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
	$(SED) 's,$(STAGING_DIR)/opt/bin/hostpython,/opt/bin/python,g' $(PKG_INSTALL_DIR)/opt/bin/weave-minimal
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/weave-minimal $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S92weave-minimal $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/var/weave
endef

define Package/weave-minimal/postinst
#!/bin/sh

echo Don\'t forget to add new user by
echo \'weave-minimal --data-dir=/opt/var/weave --register user:password\'
echo and edit host\\port at \'/opt/etc/init.d/S92weave-minimal\'
endef

$(eval $(call BuildPackage,weave-minimal))
