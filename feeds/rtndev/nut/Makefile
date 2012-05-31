#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nut
PKG_VERSION:=2.6.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.networkupstools.org/source/2.6/
PKG_MD5SUM:=8db00c21f8bc03add6e14d15f634ec6a

PKG_FIXUP:=libtool
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/nut
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+libusb +libopenssl +libltdl +libneon +libgd
	TITLE:=Network UPS Tools
	URL:=http://www.networkupstools.org
endef

define Package/nut/description
	Network UPS Tools is a collection of programs which provide a common
	interface for monitoring and administering UPS, PDU and SCD hardware.
	It uses a layered approach to connect all of the parts.
endef

CONFIGURE_ARGS += \
	--sysconfdir=/opt/etc/nut \
	--with-udev-dir=/opt/etc/udev \
	--with-hotplug-dir=/opt/etc/hotplug \
	--without-doc \
	--without-avahi \
	--without-snmp \
	--without-hal \
	--without-snmp \
	--with-statepath=/opt/var/state/ups \
	--with-pidpath=/opt/var/run \
	--with-cgi \
	--without-wrap \
	--with-htmlpath=/opt/share/www/nut \
	--with-cgipath=/opt/share/www/cgi-bin/nut \
	--disable-static

TARGET_LDFLAGS += \
	-Wl,-rpath-link=$(STAGING_DIR)/opt/lib \
	-lm

define Package/nut/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/* $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/hotplug/usb $(1)/opt/etc/nut $(1)/opt/etc/udev/rules.d
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/hotplug/usb/* $(1)/opt/etc/hotplug/usb
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/nut/* $(1)/opt/etc/nut
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/udev/rules.d/52-nut-usbups.rules $(1)/opt/etc/udev/rules.d
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/* $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/share/www/cgi-bin/nut $(1)/opt/share/www/nut
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/{cmdvartab,driver.list} $(1)/opt/share
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/share/www/nut/{bottom.html,header.html,index.html,nut-banner.png} $(1)/opt/share/www/nut
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/share/www/cgi-bin/nut/*.cgi $(1)/opt/share/www/cgi-bin/nut
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/{S14usbhid-ups,S15upsd} $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,nut))