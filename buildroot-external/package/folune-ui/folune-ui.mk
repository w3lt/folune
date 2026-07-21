################################################################################
#
# folune-ui
#
################################################################################

FOLUNE_UI_VERSION = 0.1.0
FOLUNE_UI_SITE = $(BR2_EXTERNAL_FOLUNE_PATH)/../apps/folune-ui
FOLUNE_UI_SITE_METHOD = local
FOLUNE_UI_LICENSE = PROPRIETARY
FOLUNE_UI_DEPENDENCIES = lvgl libdrm

$(eval $(cmake-package))
