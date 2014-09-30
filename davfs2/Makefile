#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=davfs2
PKG_VERSION:=1.5.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.savannah.gnu.org/releases/davfs2/
PKG_MD5SUM:=376bc9346454135cba78afacbcb23f86

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/davfs2
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Filesystem
	DEPENDS:=libneon
	TITLE:=Mounts a WebDAV resource
	URL:=http://savannah.nongnu.org/projects/davfs2
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/davfs2/description
 Mount a WebDAV resource as a regular file system. davfs2 will work with
 most WebDAV servers needing little or no configuration.
endef

CONFIGURE_ARGS += \
	--with-libintl-prefix=$(INTL_PREFIX) \
	--with-libiconv-prefix=$(ICONV_PREFIX) \
	--with-neon=$(STAGING_DIR)/opt \
	dav_user=nobody \
	dav_group=nobody \
	ssbindir=/opt/sbin \
	dav_localstatedir=/opt/var/run \
	dav_syscachedir=/opt/var/cache \

TARGET_CPPFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE

define Package/davfs2/conffiles
/opt/etc/davfs2/davfs2.conf
/opt/etc/davfs2/secrets
endef

define Package/davfs2/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/{,u}mount.davfs $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/davfs2/certs/private
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/davfs2/{davfs2.conf,secrets} $(1)/opt/etc/davfs2/
	$(INSTALL_DIR) $(1)/opt/var/{run,cache}
endef

$(eval $(call BuildPackage,davfs2))
