include $(TOPDIR)/rules.mk

PKG_NAME:=aria2
PKG_VERSION:=1.13.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/aria2
PKG_MD5SUM:=b86a5bd4a94e465a58656f71b48c90b9


PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)



include $(INCLUDE_DIR)/package.mk


define Package/aria2
SECTION:=net
CATEGORY:=Network
TITLE:=download manager
URL:=http://aria2.sourceforge.net/
DEPENDS:=+libxml2 +libstdcpp
endef

define Package/aria2/description
	download manager
endef

define Package/aria2/conffiles
/opt/etc/aria2/aria2.conf
endef

CONFIGURE_ARGS += \
	--with-openssl-prefix="$(STAGING_DIR)/opt/include/openssl" \
	--with-libz-prefix="$(STAGING_DIR)/opt/include" \
	--without-gnutls \
	--without-libexpat \
	--with-openssl \
	--with-libxml2 \
	--without-libcares \
	--without-sqlite3 \
	--disable-nls \
	--disable-static \
	--oldincludedir=$(PKG_BUILD_DIR)




define Package/aria2/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/aria2c $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/aria2
	$(CP) ./files/aria2.conf $(1)/opt/etc/aria2/aria2.conf
endef

$(eval $(call BuildPackage,aria2))
