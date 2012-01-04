include $(TOPDIR)/rules.mk


PKG_NAME:=microdc2
PKG_VERSION:=0.15.6
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://savio.km.ua/download/microdc2
PKG_MD5SUM:=9175a7463936fe89e2e22c8ae2f5e020
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/microdc2
	SECTION:=net
	CATEGORY:=Network
	TITLE:=microdc2
	DEPENDS:=$(ICONV_DEPENDS) +libxml2 +libreadline +libncurses
	URL:=http://corsair626.no-ip.org/microdc
endef

define Package/microdc2/description
	A command-line based Direct Connect client.
endef

CONFIGURE_ARGS += \
	--disable-static \
	--disable-rparh

define Build/Compile
	rm -rf $(PKG_INSTALL_DIR)
	mkdir -p $(PKG_INSTALL_DIR)
	$(MAKE) -C $(PKG_BUILD_DIR) \
		LTLIBICONV="" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		install
endef

define Package/microdc2/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/microdc2 $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/tthsum $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(CP) ./files/microdc2.conf $(1)/opt/etc/
endef

$(eval $(call BuildPackage,microdc2))
