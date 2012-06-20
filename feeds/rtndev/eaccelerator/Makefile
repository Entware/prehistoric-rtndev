#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=php5-mod-eaccelerator
PKG_VERSION:=0.9.6.1
PKG_RELEASE:=1

PKG_SOURCE:=eaccelerator-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/eaccelerator
PKG_MD5SUM:=32ccd838e06ef5613c2610c1c65ed228
PKG_BUILD_DIR:=$(BUILD_DIR)/eaccelerator-$(PKG_VERSION)
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/php5-mod-eaccelerator
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=PHP
	DEPENDS:=+php5
	TITLE:=php5-mod-eaccelerator
	URL:=http://sourceforge.net/projects/eaccelerator
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/php5-mod-eaccelerator/description
 eAccelerator is a free open source PHP accelerator and optimizer for PHP.
endef

TARGET_CPPFLAGS += \
	-DMM_SEM_IPC \
	-DMM_SHM_IPC \
	-I$(STAGING_DIR_HOST)/opt/include/php \
	-I$(STAGING_DIR_HOST)/opt/include/php/main \
	-I$(STAGING_DIR_HOST)/opt/include/php/Zend \
	-I$(STAGING_DIR_HOST)/opt/include/php/TSRM \

CONFIGURE_ARGS += \
	--with-php-config=$(STAGING_DIR_HOST)/opt/bin/php-config \
	--with-eaccelerator-userid='"nobody"' \
	--enable-eaccelerator=shared \

define Build/Configure
	( cd $(PKG_BUILD_DIR); $(STAGING_DIR_HOST)/opt/bin/phpize )
	$(call Build/Configure/Default)
endef

define Package/php5-mod-eaccelerator/install
	$(INSTALL_DIR) $(1)/opt/tmp
	$(INSTALL_DIR) $(1)/opt/tmp/eaccelerator
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DIR) $(1)/opt/etc/php5
	$(CP) ./files/eaccelerator.ini $(1)/opt/etc/php5
	$(INSTALL_DIR) $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/lib/php
	$(CP) $(PKG_BUILD_DIR)/modules/eaccelerator.so $(1)/opt/lib/php
endef

$(eval $(call BuildPackage,php5-mod-eaccelerator))
