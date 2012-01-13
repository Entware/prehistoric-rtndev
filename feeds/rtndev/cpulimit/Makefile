include $(TOPDIR)/rules.mk

PKG_NAME:=cpulimit
PKG_RELEASE:=1
PKG_REV:=41
PKG_VERSION:=r$(PKG_REV)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://cpulimit.svn.sourceforge.net/svnroot/cpulimit/trunk
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=r$(PKG_REV)
PKG_SOURCE_PROTO:=svn

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


define Package/cpulimit/compile
	$(MAKE) -C "$(PKG_BUILD_DIR)" \
	CFLAGS="$(CFLAGS)"
endef

define Package/cpulimit/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cpulimit $(1)/opt/bin/
endef

$(eval $(call BuildPackage,cpulimit))
