include $(TOPDIR)/rules.mk

PKG_NAME:=binkd
PKG_VERSION:=1.0a-561
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=:pserver:binkd@cvs.happy.kiev.ua:/cvs
PKG_SOURCE_SUBDIR:=binkd
#Embedded dev support was broken between r562 and r565
PKG_SOURCE_VERSION:=-D'08/19/2011'
PKG_SOURCE_PROTO:=cvs

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/binkd
	SUBMENU:=FTN
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+zlib +libbz2
	TITLE:=transfers files between two Fidonet systems over TCP/IP
	URL:=cvs.happy.kiev.ua
endef

define Package/binkd/description
	Binkd is a Fidonet mailer designed to operate via TCP/IP networks. As a
	FTN-compatible internet daemon, it makes possible efficient utilization
	of  TCP/IP protocol suite as a transport layer in FTN-based (Fido Tech-
	nology Network) networks.
endef

define Package/binkd/conffiles
/opt/etc/binkd/binkd.conf
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) $(PKG_BUILD_DIR)/mkfls/unix/* $(PKG_BUILD_DIR)
endef

define Package/binkd/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/binkd $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/binkd.conf $(1)/opt/etc/binkd.conf.dist
endef

$(eval $(call BuildPackage,binkd))
