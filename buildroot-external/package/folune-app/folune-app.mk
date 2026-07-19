################################################################################
#
# folune-app
#
################################################################################

FOLUNE_APP_VERSION = 0.1.0
FOLUNE_APP_SITE = $(BR2_EXTERNAL_FOLUNE_PATH)/../crates/folune-app
FOLUNE_APP_SITE_METHOD = local
FOLUNE_APP_LICENSE = PROPRIETARY

$(eval $(cargo-package))

define FOLUNE_APP_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(FOLUNE_APP_PKGDIR)/S50folune \
		$(TARGET_DIR)/etc/init.d/S50folune
endef
