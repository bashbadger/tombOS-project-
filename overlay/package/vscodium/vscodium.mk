PKG_NAME = vscodium
PKG_VERSION = 1.92.0
PKG_SITE = https://github.com/VSCodium/vscodium/releases/download/$(PKG_VERSION)
PKG_SOURCE = VSCodium-linux-x64-$(PKG_VERSION).tar.gz
PKG_LICENSE = MIT
PKG_DEPENDENCIES =
PKG_INSTALL = YES
PKG_BINARIES = code

define PKG_DOWNLOAD_CMDS
	$(WGET) $(PKG_SITE)/$(PKG_SOURCE) -O $(DL_DIR)/$(PKG_SOURCE)
endef

define PKG_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/share/vscodium
	$(INSTALL) -d $(TARGET_DIR)/usr/bin
	$(TAR) -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(TARGET_DIR)/usr/share/vscodium --strip-components=1
	ln -sf /usr/share/vscodium/code $(TARGET_DIR)/usr/bin/code
endef

$(eval $(generic-package))
