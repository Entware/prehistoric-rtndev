#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=xpdf
PKG_VERSION:=3.03
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=ftp://ftp.foolabs.com/pub/xpdf
PKG_MD5SUM:=af75f772bee0e5ae4a811ff9d03eac5a

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/xpdf
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+libstdcpp
	TITLE:=PDF manipulations tool
	URL:=http://www.foolabs.com/xpdf/
	MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/xpdf/description
 Xpdf project includes a PDF text extractor, PDF-to-PostScript converter, and
 various other utilities.
endef

CONFIGURE_ARGS += \
	--enable-cmyk \
	--enable-fixedpoint \
	--enable-multithreaded \
	--enable-exceptions \
	--without-x \
	--with-Xpm-library="no" \
	--with-Xext-library="no" \
	--with-Xp-library="no" \
	--with-Xt-library="no" \
	--with-Xm-library="no" \
	--with-Sgm-library="no" \
	--with-freetype2-library="no" \
	--with-libpaper-library="no" \

define Package/xpdf/conffiles
/opt/etc/xpdfrc
endef

define Package/xpdf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) \
	    $(PKG_INSTALL_DIR)/opt/bin/pdf{detach,fonts,images,info,tops,totext} \
	    $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/xpdfrc $(1)/opt/etc/
endef

$(eval $(call BuildPackage,xpdf))
