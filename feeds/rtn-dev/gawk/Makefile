# 2010-06-22 22:44 jirka $

include $(TOPDIR)/rules.mk

PKG_NAME:=gawk
PKG_VERSION:=3.1.8
PKG_RELEASE:=1

PKG_SOURCE:=gawk-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.gnu.org/gnu/gawk/
PKG_MD5SUM:=35937a0f83f0efe7a8c2dee635624784
PKG_CAT:=zcat

PKG_BUILD_DIR:=$(BUILD_DIR)/gawk-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/gawk
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=GAWK
	URL:=http://www.gnu.org/software/gawk/
endef

define Package/gawk/description
	GNU version of AWK.
endef

define Package/gawk/install
	$(INSTALL_DIR) $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/gawk $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/gawk $(1)/opt/bin/gawk-3.1.8
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/awklib/igawk $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/pgawk $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/libexec/
	$(INSTALL_DIR) $(1)/opt/libexec/awk/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/awklib/grcat $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/awklib/pwcat $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/share/
	$(INSTALL_DIR) $(1)/opt/share/awk/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/awklib/eg/lib/* $(1)/opt/share/awk
endef

$(eval $(call BuildPackage,gawk))
