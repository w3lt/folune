################################################################################
#
# lvgl
#
################################################################################

LVGL_VERSION = 9.5.0
LVGL_SITE = $(call github,lvgl,lvgl,v$(LVGL_VERSION))
LVGL_LICENSE = MIT
LVGL_LICENSE_FILES = LICENCE.txt
LVGL_INSTALL_STAGING = YES
LVGL_DEPENDENCIES = libdrm

LVGL_CONF_OPTS = \
	-DBUILD_SHARED_LIBS=OFF \
	-DLV_BUILD_CONF_PATH=$(LVGL_PKGDIR)/lv_conf.h \
	-DCONFIG_LV_BUILD_EXAMPLES=OFF \
	-DCONFIG_LV_BUILD_DEMOS=OFF \
	-DCONFIG_LV_USE_THORVG_INTERNAL=OFF \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include/libdrm" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include/libdrm"

$(eval $(cmake-package))
