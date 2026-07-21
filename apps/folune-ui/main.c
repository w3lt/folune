#include <lvgl.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

#define FOLUNE_DRM_DEVICE "/dev/dri/card0"

static uint32_t monotonic_milliseconds(void) {
  struct timespec now;

  if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
    return 0;
  }

  uint64_t milliseconds =
      (uint64_t)now.tv_sec * 1000U + (uint64_t)now.tv_nsec / 1000000U;

  return (uint32_t)milliseconds;
}

int main() {
  lv_init();
  lv_tick_set_cb(monotonic_milliseconds);

  lv_display_t *display = lv_linux_drm_create();
  if (display == NULL) {
    fprintf(stderr, "folune-ui: failed to create DRM display\n");
    return 1;
  }

  lv_result_t result = lv_linux_drm_set_file(display, FOLUNE_DRM_DEVICE, -1);

  if (result != LV_RESULT_OK) {
    fprintf(stderr, "folune-ui: failed to open %s\n", FOLUNE_DRM_DEVICE);
    return 1;
  }

  lv_obj_t *screen = lv_screen_active();

  lv_obj_set_style_bg_color(screen, lv_color_hex(0xF4F0E8), LV_PART_MAIN);

  lv_obj_set_style_bg_opa(screen, LV_OPA_COVER, LV_PART_MAIN);

  lv_obj_t *label = lv_label_create(screen);

  lv_label_set_text(label, "Folune");

  lv_obj_set_style_text_color(label, lv_color_hex(0x202020), LV_PART_MAIN);

  lv_obj_center(label);

  while (true) {
    uint32_t sleep_ms = lv_timer_handler();

    if (sleep_ms == LV_NO_TIMER_READY || sleep_ms > LV_DEF_REFR_PERIOD) {
      sleep_ms = LV_DEF_REFR_PERIOD;
    }

    usleep((useconds_t)sleep_ms * 1000U);
  }
}
