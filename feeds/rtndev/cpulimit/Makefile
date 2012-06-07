include $(TOPDIR)/rules.mk

PKG_NAME:=cpulimit
PKG_VERSION:=1.7
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/limitcpu
PKG_MD5SUM:=7440198b930ac77bcb13b4e24c72e06f

include $(INCLUDE_DIR)/package.mk

define Package/cpulimit
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=CPU usage limiter
	URL:=http://cpulimit.sourceforge.net/
endef

define Package/cpulimit/description
	cpulimit is a simple program which attempts to limit the cpu usage of a process
endef

define Package/cpulimit/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cpulimit $(1)/opt/bin/
endef

$(eval $(call BuildPackage,cpulimit))
