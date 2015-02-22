#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-werkzeug
PKG_VERSION:=0.10-20130904
PKG_RELEASE:=1

PKG_REV:=e96a92443f928e243706c655a183cde5eb508347
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/mitsuhiko/werkzeug.git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_BUILD_DEPENDS:=distribute/host

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-werkzeug
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	DEPENDS:=+python
	TITLE:=python utilities for WSGI applications
	URL:=http://werkzeug.pocoo.org/
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/python-werkzeug/description
 Werkzeug started as simple collection of various utilities for WSGI
 applications and has become one of the most advanced WSGI utility modules.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/opt --root=$(PKG_INSTALL_DIR))
endef

define Package/python-werkzeug/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-werkzeug))
