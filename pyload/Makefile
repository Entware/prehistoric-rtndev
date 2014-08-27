#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pyload
PKG_VERSION:=0.4.10
PKG_RELEASE:=1

PKG_REV:=$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=git://github.com/pyload/pyload.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/pyload
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+python +pyopenssl +python-curl +python-crypto +python-django \
	+python-expat +python-imaging-library +python-sqlite3 +js \
	+tesseract +unrar
  TITLE:=A fast, lightweight and full featured download manager
  URL:=http://pyload.org
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)/pyload
	tar xvfj $(DL_DIR)/$(PKG_SOURCE)
	$(CP) ./$(PKG_NAME)-$(PKG_VERSION)/* $(PKG_BUILD_DIR)/pyload
	chmod +x $(PKG_BUILD_DIR)/pyload/*.py
	rm -rf ./$(PKG_NAME)-$(PKG_VERSION)*
endef

define Build/Compile
endef

define Package/pyload/install
	$(INSTALL_DIR) $(1)/opt/share/python
	$(CP) $(PKG_BUILD_DIR)/pyload $(1)/opt/share/python/
	$(INSTALL_DIR) $(1)/opt/bin
	$(LN) ../share/python/pyload/pyload.py $(1)/opt/bin/pyload
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S51pyload $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,pyload))
