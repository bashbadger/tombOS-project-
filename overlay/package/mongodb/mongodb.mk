PKG_NAME = mongodb
PKG_VERSION = 6.0.13
PKG_SITE = https://fastdl.mongodb.org/linux
PKG_SOURCE = mongodb-linux-x86_64-$(PKG_VERSION).tgz
PKG_LICENSE = SSPL
PKG_DEPENDENCIES =
PKG_INSTALL = YES
PKG_BINARIES = mongod mongodump mongo

define PKG_DOWNLOAD_CMDS
	$(WGET) $(PKG_SITE)/$(PKG_SOURCE) -O $(DL_DIR)/$(PKG_SOURCE)
endef

define PKG_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/bin
	$(INSTALL) -d $(TARGET_DIR)/var/lib/mongodb
	$(TAR) -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(TARGET_DIR)/usr/bin --strip-components=1 mongod mongodump mongo
endef

$(eval $(generic-package))
