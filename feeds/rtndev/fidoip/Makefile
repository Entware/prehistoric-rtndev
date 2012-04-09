include $(TOPDIR)/rules.mk

PKG_NAME:=fidoip
PKG_VERSION:=1.0.5_3
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/fidoip
	SUBMENU:=FTN
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+binkd +husky +golded-nsf +zip +unzip +bash
	TITLE:=Complete Fidonet software suite
	URL:=http://sourceforge.net/projects/fidoip/
endef

define Package/fidoip/description
	Fidoip is a complete Fidonet software suite with all necessery script and
	configuration files. It's intended to be use well both in IP-point or in IP-node mode.
endef

define Package/fidoip/conffiles
/opt/etc/fido/config
/opt/etc/binkd.cfg
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/fidoip/postinst
#!/bin/sh

echo "Just type setup_config.bash to set up IP-point settings."
echo "Use send/recv scripts to send or receive fidomail and"
echo "gl/ge scripts to run GoldED in UTF8 or KOI8 locales."
endef

define Package/fidoip/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) ./files/sbin/* $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(CP) ./files/etc/* $(1)/opt/etc
	$(INSTALL_DIR) $(1)/opt/var/fido/{2uplink,announce,badarea,carbonarea,fghigetdir,filebox,flags,inbound,localinb,magic,msgbasedir,netmailarea,nodelist,outbound,outfile,protinb,public,tempinb,tempoutb,uudecode}
	$(INSTALL_DATA) ./files/nodelist/* $(1)/opt/var/fido/nodelist
	touch $(1)/opt/var/fido/{binkd.log,echotoss.log,golded.log,hpt.log,htick.log,import.log,sqpack.log}
endef

$(eval $(call BuildPackage,fidoip))
