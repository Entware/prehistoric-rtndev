#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=iproute2-legacy
PKG_VERSION:=2.6.39
PKG_RELEASE:=1

PKG_SOURCE:=iproute2-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://devresources.linux-foundation.org/dev/iproute2/download/
PKG_MD5SUM:=8a3b6bc77c2ecf752284aa4a6fc630a6
PKG_BUILD_PARALLEL:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/iproute2-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/iproute2-legacy/Default
	SECTION:=net
	CATEGORY:=Network
	URL:=http://linux-net.osdl.org/index.php/Iproute2
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/ip-legacy
$(call Package/iproute2-legacy/Default)
	SUBMENU:=Routing and Redirection
	TITLE:=Routing control utility
endef

define Package/ip-legacy/conffiles
/opt/etc/iproute2/rt_tables
endef

define Package/tc-legacy
$(call Package/iproute2-legacy/Default)
	TITLE:=Traffic control utility
endef

define Package/genl-legacy
$(call Package/iproute2-legacy/Default)
	TITLE:=General netlink utility frontend
endef

define Build/Configure
	mv $(PKG_BUILD_DIR)/include/libnetlink.h $(PKG_BUILD_DIR)/include/libnetlink-legacy.h
	$(SED) "s,-I/usr/include/db3,," $(PKG_BUILD_DIR)/Makefile
	$(SED) "s,^KERNEL_INCLUDE.*,KERNEL_INCLUDE=$(LINUX_DIR)/include," \
		$(PKG_BUILD_DIR)/Makefile
	$(SED) "s,^LIBC_INCLUDE.*,LIBC_INCLUDE=$(STAGING_DIR)/include," \
		$(PKG_BUILD_DIR)/Makefile
	# For now disable compiling of the misc directory because it seems to fail
	rm -rf $(PKG_BUILD_DIR)/misc
	$(SED) "s, misc,," $(PKG_BUILD_DIR)/Makefile
	echo "static const char SNAPSHOT[] = \"$(PKG_VERSION)-$(PKG_RELEASE)-openwrt\";" \
		> $(PKG_BUILD_DIR)/include/SNAPSHOT.h
endef

MAKE_FLAGS += \
	EXTRA_CCOPTS="$(TARGET_CFLAGS)" \
	KERNEL_INCLUDE="$(LINUX_DIR)/include" \
	FPIC="$(FPIC)"

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)/netem \
		HOSTCC="$(HOSTCC)"  EXTRA_CCOPTS="$(TARGET_CFLAGS)" \
		CFLAGS="-D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall \
		-I../include -DRESOLVE_HOSTNAMES"
	$(MAKE_VARS) $(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) all
	$(MAKE_VARS) $(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)/tc $(MAKE_FLAGS) tc
	$(MAKE_VARS) $(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)/ip $(MAKE_FLAGS) ip
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_BUILD_DIR)/include/libnetlink-legacy.h $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/lib/libnetlink.a $(1)/opt/lib/libnetlink-legacy.a
endef

define Package/ip-legacy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/iproute2
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/iproute2/rt_tables $(1)/opt/etc/iproute2
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ip/ip $(1)/opt/sbin/
endef

define Package/tc-legacy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tc/tc $(1)/opt/sbin/
endef

define Package/genl-legacy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/genl/genl $(1)/opt/sbin/
endef

$(eval $(call BuildPackage,ip-legacy))
$(eval $(call BuildPackage,tc-legacy))
$(eval $(call BuildPackage,genl-legacy))
