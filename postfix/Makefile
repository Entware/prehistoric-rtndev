#
# Copyright (C) 2011-2014 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Some patches taken from https://lists.openwrt.org/pipermail/openwrt-devel/2013-November/022556.html

include $(TOPDIR)/rules.mk

PKG_NAME:=postfix
PKG_VERSION:=2.11.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=ftp://ftp.opennet.ru/pub/postfix/official
PKG_MD5SUM:=8e762068938ffc2160645b989bb77c4d

PKG_BUILD_DEPENDS:=postfix/host

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk

define Package/postfix
	SECTION:=mail
	CATEGORY:=Mail
	DEPENDS:=+libsasl2 +libpcre +libdb47
	TITLE:=a mail server
	URL:=http://postfix.sourceforge.net
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/postfix/description
 Postfix is Wietse Venema's mail server that started life at IBM research
 as an alternative to the widely-used Sendmail program.
endef

POSTFIX_CARGS = \
	-DDEF_COMMAND_DIR=\"/opt/sbin\" \
	-DDEF_CONFIG_DIR=\"/opt/etc/postfix\" \
	-DDEF_DAEMON_DIR=\"/opt/libexec/postfix\" \
	-DDEF_MAILQ_PATH=\"/opt/bin/mailq\" \
	-DDEF_HTML_DIR=\"/opt/share/doc/postfix/html\" \
	-DDEF_MANPAGE_DIR=\"/opt/man\" \
	-DDEF_NEWALIAS_PATH=\"/opt/bin/newaliases\" \
	-DDEF_QUEUE_DIR=\"/opt/var/spool/postfix\" \
	-DDEF_README_DIR=\"/opt/share/doc/postfix/readme\" \
	-DDEF_SENDMAIL_PATH=\"/opt/sbin/sendmail\" \
	-DHAS_PCRE \
	-DUSE_CYRUS_SASL \
	-DUSE_SASL_AUTH \
	-DNO_NIS \

HOST_POSTFIX_CARGS = \
	-DDEF_COMMAND_DIR=\"/opt/sbin\" \
	-DDEF_CONFIG_DIR=\"/opt/etc/postfix\" \
	-DDEF_DAEMON_DIR=\"/opt/libexec/postfix\" \
	-DDEF_MAILQ_PATH=\"/opt/bin/mailq\" \
	-DDEF_HTML_DIR=\"/opt/share/doc/postfix/html\" \
	-DDEF_MANPAGE_DIR=\"/opt/man\" \
	-DDEF_NEWALIAS_PATH=\"/opt/bin/newaliases\" \
	-DDEF_QUEUE_DIR=\"/opt/var/spool/postfix\" \
	-DDEF_README_DIR=\"/opt/share/doc/postfix/readme\" \
	-DDEF_SENDMAIL_PATH=\"/opt/sbin/sendmail\" \
	-DNO_DB \
	-DNO_DEVPOLL \
	-DNO_EPOLL \
	-DNO_PCRE \
	-DNO_TLS \
	-DNO_NIS \

MAKE_VARS += \
	CCARGS='$(POSTFIX_CARGS)' \
	AUXLIBS="$(TARGET_LDFLAGS) -lpcre -lnsl -lsasl2 -ldl -lssl" \
	OPT="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \

HOST_MAKE_VARS += \
	CCARGS='$(HOST_POSTFIX_CARGS)' \
	AUXLIBS="-lresolv" \

TARGET_CFLAGS += \
	-DNO_NIS \

HOST_CFLAGS += \
	-DNO_NIS \
	-DNO_TLS \
	-DNO_DB \

define Build/Configure
	(cd $(PKG_BUILD_DIR); \
	$(MAKE_VARS) $(MAKE) makefiles \
	)
endef

define Host/Configure
	(cd $(HOST_BUILD_DIR); \
	$(HOST_MAKE_VARS) $(MAKE) makefiles \
	)
endef

define Package/postfix/install
	# Temporary replacing native postconf with host-compiled one
	cp -f $(PKG_BUILD_DIR)/bin/postconf \
	    $(PKG_BUILD_DIR)/bin/postconf.target
	cp -f $(HOST_BUILD_DIR)/src/postconf/postconf \
	    $(PKG_BUILD_DIR)/bin/postconf
	(cd $(PKG_BUILD_DIR); \
	    $(MAKE) \
		install_root=$(1) \
		readme_directory=no \
		html_directory=no \
		manpage_directory=no \
		queue_directory=/opt/var/spool/postfix \
		data_directory=/opt/var/lib/postfix \
		command_directory=/opt/sbin \
		daemon_directory=/opt/libexec/postfix \
		sendmail_path=/opt/sbin/sendmail \
		newaliases_path=/opt/bin/newaliases \
		mailq_path=/opt/bin/mailq \
		sample_directory=/opt/etc/postfix \
		non-interactive-package \
	)
	# Removing those useless man pages
	$(RM) -r $(1)/opt/local/man
	# Fixing configuration (we don't want mail directory to be on tmpfs)
	$(PKG_BUILD_DIR)/bin/postconf \
	    -c $(1)/opt/etc/postfix/ \
	    -e \
		"data_directory = /opt/var/lib/postfix" \
		"mail_spool_directory = /opt/var/mail"
	# Restoring target postconf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/postconf.target \
	    $(1)/opt/sbin/postconf
	$(INSTALL_DIR) $(1)/opt/var/{spool,lib}/postfix
	$(INSTALL_DIR) $(1)/opt/var/mail
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S69postfix $(1)/opt/etc/init.d
endef

define Host/Install
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,postfix))