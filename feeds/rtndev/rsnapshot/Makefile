#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rsnapshot
PKG_VERSION:=1.3.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:= http://rsnapshot.org/downloads/
PKG_MD5SUM:=588f92995dcf60a6ea6df8d94a017e7e

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/rsnapshot
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=File Transfer
  TITLE:=filesystem snapshot utility for making backups
  DEPENDS:=+rsync +perl +perlbase-autoloader +perlbase-class +perlbase-cwd +perlbase-dirhandle +perlbase-essential \
  	+perlbase-fcntl +perlbase-file +perlbase-getopt +perlbase-io +perlbase-posix +perlbase-selectsaver \
  	+perlbase-symbol +perlbase-tie +perlbase-xsloader +coreutils-cp +coreutils-du +coreutils-rm
  URL:=http://rsnapshot.org/
  MAINTAINER:=Entware team, wl500g-repo.googlecode.com
endef

define Package/rsnapshot/description
 rsnapshot is a filesystem snapshot utility for making backups of local and remote systems.
endef

define Package/rsnapshot/conffiles
/opt/etc/rsnapshot.conf
endef

CONFIGURE_ARGS += \
	--exec-prefix=/opt \
	--prefix=/opt \
	--disable-nls \
	--without-logger \
	ac_cv_path_PERL=/opt/bin/perl \
	ac_cv_path_RSYNC=/opt/bin/rsync \
	ac_cv_path_CP=/bin/cp \
	ac_cv_path_CP=/opt/bin/cp \
	ac_cv_path_RM=/opt/bin/rm \
	ac_cv_path_DU=/opt/bin/du \

	#
	#--with-perl=/opt/bin/perl \
	#--with-rsync=/opt/bin/rsync \
	#--with-cp=/bin/cp

define Package/rsnapshot/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/$(PKG_NAME) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/$(PKG_NAME)-diff $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/opt/etc/$(PKG_NAME).conf.default $(1)/opt/etc/$(PKG_NAME).conf
	$(INSTALL_DIR) $(1)/opt/var/log
	$(INSTALL_DIR) $(1)/opt/var/run
endef

$(eval $(call BuildPackage,rsnapshot))
