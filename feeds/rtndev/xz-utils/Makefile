#
# Copyright (C) 2011-2012 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=xz-utils
PKG_VERSION:=5.0.4
PKG_RELEASE:=1

PKG_SOURCE:=xz-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://tukaani.org/xz
PKG_MD5SUM:=161015c4a65b1f293d31810e1df93090
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/xz-$(PKG_VERSION)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/xz-utils/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=compression
  TITLE:=XZ-format compression
  URL:=http://tukaani.org/xz
  MAINTAINER:=Entware team, wl500g-repo.googlecode.com
  VARIANT:=shared
endef

define Package/xz-utils
$(call Package/xz-utils/Default)
  TITLE+= utilities
  DEPENDS:=+libpthread +liblzma
endef

define Package/xz-lzma
$(call Package/xz-utils/Default)
  DEPENDS:=+xz-utils
  TITLE+= utilities - compatibility commands
endef

define Package/xzdec
$(call Package/xz-utils/Default)
  TITLE+= utilities - tiny decompressors
  VARIANT:=static
endef

define Package/liblzma
$(call Package/xz-utils/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libpthread
  TITLE+= library
endef  

define Package/xz-utils/description
  This package provides the command line tools for working with XZ compression, 
  including xz, unxz, xzcat, xzgrep, and so on. They can also handle the older 
  LZMA format, and if invoked via appropriate symlinks will emulate the behavior 
  of the commands in the lzma package.
endef

define Package/xz-lzma/description
  This package provides symbolic links allowing xz-utils to provide the same interface
  for manipulating LZMA files as the lzma package. The xz-utils package can handle 
  LZMA files on its own; this package is only necessary when using scripts 
  or other programs that require the older command names.
endef

define Package/xzdec/description
  This package provides the xzdec and lzmadec utilities, which write the decompressed 
  version of a compressed file to standard output. The binaries are very small, 
  and they are linked statically against liblzma so they can be used on machines
  without a compatible version of liblzma installed.
endef

define Package/liblzma/description
  XZ is the successor to the Lempel-Ziv/Markov-chain Algorithm compression format,
  which provides memory-hungry but powerful compression (often better than bzip2)
  and fast, easy decompression. The native format of liblzma is XZ; it also supports
  raw (headerless) streams and the older LZMA format used by lzma.
  (For 7-Zip's related format, use the p7zip package instead.) 
endef

TARGET_CFLAGS += --std=c99

CONFIGURE_ARGS += \
	--prefix=/opt \
	--disable-nls \
	--enable-assume-ram=16

ifeq ($(BUILD_VARIANT),static)
	CONFIGURE_ARGS+= \
		--disable-shared \
		--disable-threads
endif

define Package/liblzma/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/liblzma*.so* $(1)/opt/lib/
endef

define Package/xz-utils/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{xz,lzmainfo,unxz,xzcat,xzcmp,xzdiff} $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{xzegrep,xzfgrep,xzgrep,xzless,xzmore} $(1)/opt/bin/
endef

define Package/xz-lzma/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{lzcat,lzcmp,lzdiff,lzegrep,lzfgrep,lzgrep} $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{lzless,lzma,lzmore,unlzma} $(1)/opt/bin/
endef

define Package/xzdec/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/{lzmadec,xzdec} $(1)/opt/bin
endef

ifeq ($(BUILD_VARIANT),static)
define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.{a,la} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/liblzma.pc $(1)/opt/lib/pkgconfig/
endef
else
define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.{a,la,so*} $(1)/opt/lib/
	$(INSTALL_DIR) $(1)/opt/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/pkgconfig/liblzma.pc $(1)/opt/lib/pkgconfig/
endef
endif

$(eval $(call BuildPackage,liblzma))
$(eval $(call BuildPackage,xz-utils))
$(eval $(call BuildPackage,xz-lzma))
$(eval $(call BuildPackage,xzdec))
