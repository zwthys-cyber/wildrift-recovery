#include "LVConfig.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static float value(LVConfig *c, const char *key) { return c->values[lv_config_index(key)][0]; }

int main(void) {
    LVConfig config;
    lv_config_defaults(&config);
    assert(value(&config, "smiteRange") == 83000);
    assert(value(&config, "autoSmite") == 0);
    assert(fabsf(value(&config, "minimapScale") - 1.04f) < 0.00001f);
    LVParseReport report;
    assert(!lv_config_parse(&config,
        "# original Android settings\r\nversion=1\r\ndrawBox=0\r\nsmiteRange=100001\n"
        "smiteHealthThreshold=600\nminimapScale=2\nunusedOption=7\n", &report));
    assert(report.recognized == 4 && report.unknown == 1 && report.clamped == 2);
    assert(value(&config, "smiteRange") == 100000 && value(&config, "minimapScale") == 1.5f);
    assert(value(&config, "smiteHealthThreshold") == 600);
    assert(!lv_config_parse(&config, "smiteHealthThreshold=1200\n", &report));
    assert(value(&config, "smiteHealthThreshold") == 1000 && report.clamped == 1);
    LVConfig before = config;
    const char *bad[] = {"drawBox=2", "drawRay=0\nminimapScale=nan", "friendlyColor=1,0,0",
                        "enemyColor=1,0,0,inf", "smiteRange=2147483648", "version=2",
                        "drawBox=1garbage", "entityOffsetX=3abc", "broken line"};
    for (size_t i = 0; i < sizeof(bad)/sizeof(*bad); ++i) {
        assert(lv_config_parse(&config, bad[i], &report));
        assert(!memcmp(&before, &config, sizeof(config)));
    }
    assert(!lv_config_parse(&config, "drawBox=0\ndrawBox=true\nneutralColor=1,0.5,0,1\n", &report));
    assert(value(&config, "drawBox") == 1);
    assert(config.values[lv_config_index("neutralColor")][1] == 0.5f);
    size_t size = lv_config_serialize(&config, NULL, 0);
    char *text = malloc(size);
    assert(text && lv_config_serialize(&config, text, size) == size && strlen(text) + 1 == size);
    LVConfig decoded;
    lv_config_defaults(&decoded);
    assert(!lv_config_parse(&decoded, text, &report) && report.recognized == 57);
    char *again = malloc(size);
    assert(lv_config_serialize(&decoded, again, size) == size && !strcmp(text, again));
    char tiny[2] = {'x', 'x'};
    assert(lv_config_serialize(&config, tiny, sizeof(tiny)) == size && tiny[1] == 0);
    char *large = malloc(LV_CONFIG_MAX_INPUT + 2);
    memset(large, ' ', LV_CONFIG_MAX_INPUT + 1);
    large[LV_CONFIG_MAX_INPUT + 1] = 0;
    assert(lv_config_parse(&decoded, large, &report));
    free(large); free(again); free(text);
    puts("PASS: recovered defaults, Android bounds, threshold choices, atomic import, RGBA, round-trip, input limits");
    return 0;
}
