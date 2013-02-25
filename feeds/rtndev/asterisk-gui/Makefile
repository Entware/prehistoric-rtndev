#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk-gui
PKG_VERSION:=2.1.0-rc1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://downloads.asterisk.org/pub/telephony/asterisk-gui/
PKG_MD5SUM:=055bf2aaba365e696198925d039ac3cb

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/asterisk-gui
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Telephony
	DEPENDS:=+asterisk18
	TITLE:=WEB GUI for Asterisk
	URL:=$(PKG_SOURCE_URL)
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/asterisk-gui/description
 Asterisk-GUI is a framework for the creation of graphical interfaces for
 configuring Asterisk.
endef


define Package/asterisk-gui/install
	$(INSTALL_DIR) $(1)/opt/lib/asterisk/{scripts,static-http,gui-backups}
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/var/lib/asterisk/scripts/* $(1)/opt/lib/asterisk/scripts
	$(CP) $(PKG_INSTALL_DIR)/opt/var/lib/asterisk/static-http/ $(1)/opt/lib/asterisk/
	$(INSTALL_DIR) $(1)/opt/var/lib/
	ln -s /opt/lib/asterisk $(1)/opt/var/lib/
endef

$(eval $(call BuildPackage,asterisk-gui))
