#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=smstools3
PKG_VERSION:=3.1.15
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://smstools3.kekekasvi.com/packages
PKG_MD5SUM:=0241ef60e646fac1a06254a848e61ed7

include $(INCLUDE_DIR)/package.mk

PKG_UNPACK:=gzip -dc $(DL_DIR)/$(PKG_SOURCE) | $(TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xf -

define Package/smstools3
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+iconv
	TITLE:=smstools3
	URL:=http://smstools3.kekekasvi.com
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/smstools3/description
 The SMS Server Tools 3 is a SMS Gateway software which can send and receive
 short messages through GSM modems and mobile phones.
endef

define Package/smstools3/conffiles
/opt/etc/smsd.conf
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/src \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CPPFLAGS) -D NUMBER_OF_MODEMS=64 -D NOSTATS -D_FILE_OFFSET_BITS=64 -W -Wall" \
		LFLAGS="$(TARGET_LDFLAGS)" \
		VERSION="3.1.14"
endef

define Package/smstools3/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/smsd $(1)/opt/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/scripts/{sendsms,sms2html,sms2unicode,unicode2sms} $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/examples/smsd.conf.easy $(1)/opt/etc/smsd.conf
	$(INSTALL_DIR) $(1)/opt/var/spool/sms/{incoming,outgoing,checked} $(1)/opt/var/run
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S53smstools3 $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,smstools3))
