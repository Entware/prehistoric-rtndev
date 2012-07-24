#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mcabber
PKG_VERSION:=0.10.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://mcabber.com/files/
PKG_MD5SUM:=fe96beab30f535d5d6270fd1719659b4

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/mcabber/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Instant Messaging
	DEPENDS:=+libncursesw +libloudmouth1 +libcharset +libidn
	TITLE:=Jabber console client
	URL:=http://mcabber.com
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/mcabber/description
  mcabber is a small Jabber console client. It includes features such as SASL/SSL/TLS support,
  MUC (Multi-User Chat) support, history logging, command completion, dynamic modules and external action triggers.
  (For PGP and OTR support install mcabber-crypto package).
endef

define Package/mcabber/conffiles
/opt/etc/.mcabber/mcabberrc
endef

define Package/mcabber
$(call Package/mcabber/Default)
  VARIANT:=normal
endef

define Package/mcabber-help
$(call Package/mcabber/Default)
  TITLE:=Help files for mcabber
  DEPENDS:=
  VARIANT:=normal
endef

define Package/mcabber-help/description
  This package provides only help files for mcabber.
endef

define Package/mcabber-crypto
$(call Package/mcabber/Default)
  DEPENDS:= +mcabber +libgpgme +libotr 
  TITLE:= Binary file for mcabber with PGP and OTR support
  VARIANT:=crypto
endef

define Package/mcabber-crypto/description
  Use mcabber-crypto binary instead of mcabber for PGP or OTR.
endef

CONFIGURE_ARGS += \
        --prefix=/opt \
	--with-libidn=$(STAGING_DIR)/opt/lib \
	
ifeq ($(BUILD_VARIANT),crypto)
	CONFIGURE_ARGS+= \
		--with-gpgme-prefix=$(STAGING_DIR)/opt \
		--enable-otr
endif
		
define Package/mcabber/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mcabber/mcabber $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/lib/mcabber
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modules/beep/.libs/libbeep.so $(1)/opt/lib/mcabber
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modules/xttitle/.libs/libxttitle.so $(1)/opt/lib/mcabber
	$(INSTALL_DIR) $(1)/opt/etc/.mcabber
	chmod 0700 $(1)/opt/etc/.mcabber
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/mcabberrc.example $(1)/opt/etc/.mcabber/mcabberrc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/contrib/events/eventcmd $(1)/opt/etc/.mcabber/eventcmd.example
	$(INSTALL_DIR) $(1)/opt/etc/.mcabber/event_files
	$(INSTALL_DIR) $(1)/opt/etc/.mcabber/histo
	$(INSTALL_DIR) $(1)/opt/share/mcabber
endef

define Package/mcabber-crypto/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mcabber/mcabber $(1)/opt/bin/mcabber-crypto
	$(INSTALL_DIR) $(1)/opt/etc/.mcabber/otr
	chmod 0700 $(1)/opt/etc/.mcabber
endef

define Package/mcabber-help/install
	$(INSTALL_DIR) $(1)/opt/share/mcabber/help/{cs,de,en,fr,it,nl,pl,ru,uk}
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/doc/help/cs/*.txt $(1)/opt/share/mcabber/help/cs
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/doc/help/de/*.txt $(1)/opt/share/mcabber/help/de
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/doc/help/en/*.txt $(1)/opt/share/mcabber/help/en
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/doc/help/fr/*.txt $(1)/opt/share/mcabber/help/fr
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/doc/help/it/*.txt $(1)/opt/share/mcabber/help/it
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/doc/help/nl/*.txt $(1)/opt/share/mcabber/help/nl
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/doc/help/pl/*.txt $(1)/opt/share/mcabber/help/pl
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/doc/help/ru/*.txt $(1)/opt/share/mcabber/help/ru
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/doc/help/uk/*.txt $(1)/opt/share/mcabber/help/uk
endef

$(eval $(call BuildPackage,mcabber))
$(eval $(call BuildPackage,mcabber-help))
$(eval $(call BuildPackage,mcabber-crypto))
