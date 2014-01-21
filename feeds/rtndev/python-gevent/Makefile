#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-gevent
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE:=gevent-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/g/gevent
PKG_MD5SUM:=33aef51a06268f5903fea378e1388e4d
PKG_BUILD_DEPENDS:=python
PKG_BUILD_DIR:=$(BUILD_DIR)/gevent-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-gevent
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	DEPENDS:=+python-greenlet +libevent2
	TITLE:=Python networking library
	URL:=http://www.gevent.org/
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/python-gevent/description
 Gevent is a coroutine-based Python networking library that uses greenlet
 to provide a high-level synchronous API on top of the libevent event loop.
endef

define Build/Compile
	(cd $(PKG_BUILD_DIR)/libev; \
	$(CONFIGURE_VARS) \
	$(PKG_BUILD_DIR)/libev/configure \
	    $(CONFIGURE_ARGS) \
	);
#	(cd $(PKG_BUILD_DIR)/c-ares; \
#	touch Makefile.in; \
#	touch libcares.pc.in; \
#	$(CONFIGURE_VARS) \
#	$(PKG_BUILD_DIR)/c-ares/configure \
#	    $(CONFIGURE_ARGS) \
#	);
	$(call Build/Compile/PyMod,,install --prefix=/opt --root=$(PKG_INSTALL_DIR))
endef

define Package/python-gevent/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-gevent))
