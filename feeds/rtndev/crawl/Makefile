
include $(TOPDIR)/rules.mk

PKG_NAME:=crawl
PKG_VERSION:=0.10.2
PKG_RELEASE:=1

PKG_SOURCE:=stone_soup-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@SF/crawl-ref/Stone%20Soup/$(PKG_VERSION)
PKG_MD5SUM:=9acf8c1fe2a93d88946b86add3f482d3
PKG_BUILD_DIR:=$(BUILD_DIR)/stone_soup-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/crawl
	SECTION:=games
	CATEGORY:=Games
	DEPENDS:=+zlib +libstdcpp +libncursesw +libsqlite3
	TITLE:=Dungeon Crawl Stone Soup is a role-playing roguelike game
	URL:=http://crawl.develz.org
endef

define Package/crawl/description
	Dungeon Crawl Stone Soup is an open-source, single-player, role-playing 
	roguelike game of exploration and treasure-hunting in dungeons filled 
	with dangerous and unfriendly monsters in a quest to rescue 
	the mystifyingly fabulous Orb of Zot.
endef

define Build/Configure
endef

MAKE_FLAGS += \
	prefix=/opt \
	DESTDIR=$(PKG_INSTALL_DIR) \
	DATADIR=/opt/share/crawl/ \
	SAVEDIR=/opt/var/crawl/ \
	install

define Build/Compile
	$(MAKE_VARS) $(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)/source \
	    $(MAKE_FLAGS)
endef

define Package/crawl/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/crawl $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/share/crawl
	$(CP) $(PKG_INSTALL_DIR)/opt/share/crawl/* $(1)/opt/share/crawl/
	$(INSTALL_DIR) $(1)/opt/var/crawl/{morgue,saves}
endef

define Package/crawl/postrm
#!/bin/sh

rm -rf /opt/share/crawl
echo Crawl saves \(~5Mb\) still is in /opt/var/crawl
echo You may delete it manually later.
endef

$(eval $(call BuildPackage,crawl))
