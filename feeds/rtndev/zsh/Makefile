#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zsh
PKG_VERSION:=5.0.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/zsh
PKG_MDSUM:=b8f2ad691acf58b3252225746480dcad

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/zsh
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+librt +libgdbm +libncursesw
	TITLE:=the Z shell
	URL:=http://zsh.sourceforge.net/
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/zsh/description
 Zsh is a shell designed for interactive use,
 although it is also a powerful scripting language.
endef

CONFIGURE_VARS += \
	zsh_cv_sys_nis=no \
	zsh_cv_sys_nis_plus=no


CONFIGURE_ARGS += \
	--enable-etcdir=/opt/etc \
	--enable-multibyte

define Package/zsh/conffiles
/opt/etc/zlogin
/opt/etc/zshenv
/opt/etc/zshrc
endef

define Package/zsh/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/zsh $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/share/zsh
	$(CP) $(PKG_INSTALL_DIR)/opt/share/zsh/* $(1)/opt/share/zsh
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/StartupFiles/z* $(1)/opt/etc
endef

$(eval $(call BuildPackage,zsh))
