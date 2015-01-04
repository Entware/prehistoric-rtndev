#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=php5-mod-eaccelerator
PKG_VERSION:=0.9.6-20120816
PKG_RELEASE:=1

PKG_REV:=53c0715cb9a53089d300ac9c01fcbcf787889f53
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/eaccelerator/eaccelerator.git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/php5-mod-eaccelerator
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=PHP
	DEPENDS:=+php5
	TITLE:=php5-mod-eaccelerator
	URL:=http://sourceforge.net/projects/eaccelerator
	MAINTAINER:=Entware team, entware.wl500g.info
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

define Package/php5-mod-eaccelerator/conffiles
/opt/etc/php5/eaccelerator.ini
endef

define Build/Configure
	( cd $(PKG_BUILD_DIR); $(STAGING_DIR_HOST)/opt/bin/phpize )
	$(call Build/Configure/Default)
endef

define Package/php5-mod-eaccelerator/install
	$(INSTALL_DIR) $(1)/opt/tmp/eaccelerator $(1)/opt/var/log  $(1)/opt/etc/php5
	$(CP) $(PKG_BUILD_DIR)/eaccelerator.ini $(1)/opt/etc/php5
	$(INSTALL_DIR) $(1)/opt/lib/php
	$(CP) $(PKG_BUILD_DIR)/modules/eaccelerator.so $(1)/opt/lib/php
endef

$(eval $(call BuildPackage,php5-mod-eaccelerator))
