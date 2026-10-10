#ifndef LV_CONFIG_H
#define LV_CONFIG_H
#include <stddef.h>

#define LV_CONFIG_FIELD_COUNT 57
#define LV_CONFIG_MAX_INPUT (1024 * 1024)

typedef enum { LV_BOOL, LV_INT, LV_FLOAT, LV_COLOR } LVFieldType;
typedef struct {
    const char *key;
    LVFieldType type;
    float initial[4];
    float minimum, maximum;
    int has_bounds;
    unsigned android_offset;
} LVField;
typedef struct { float values[LV_CONFIG_FIELD_COUNT][4]; } LVConfig;
typedef struct {
    size_t recognized, unknown, invalid, clamped;
    int unsupported_version;
} LVParseReport;

extern const LVField lv_fields[LV_CONFIG_FIELD_COUNT];
void lv_config_defaults(LVConfig *config);
int lv_config_index(const char *key);
// Returns 0 on success. Invalid input never changes the field.
int lv_config_set(LVConfig *config, size_t field, const char *value, int *clamped);
// Atomic import: any invalid known field or unsupported version rejects import.
int lv_config_parse(LVConfig *config, const char *text, LVParseReport *report);
// Returns required bytes including NUL, even when capacity is insufficient.
size_t lv_config_serialize(const LVConfig *config, char *output, size_t capacity);
#endif
