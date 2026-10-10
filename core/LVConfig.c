#include "LVConfig.h"
#include <errno.h>
#include <limits.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "LVFields.inc"

static char *trim(char *s) {
    while (*s == ' ' || *s == '\t' || *s == '\r') ++s;
    size_t n = strlen(s);
    while (n && (s[n-1] == ' ' || s[n-1] == '\t' || s[n-1] == '\r')) s[--n] = 0;
    return s;
}

void lv_config_defaults(LVConfig *config) {
    if (!config) return;
    for (size_t i = 0; i < LV_CONFIG_FIELD_COUNT; ++i)
        memcpy(config->values[i], lv_fields[i].initial, sizeof(config->values[i]));
}

int lv_config_index(const char *key) {
    if (!key) return -1;
    for (size_t i = 0; i < LV_CONFIG_FIELD_COUNT; ++i)
        if (strcmp(key, lv_fields[i].key) == 0) return (int)i;
    return -1;
}

static int parse_float(const char *text, float *result, const char **end) {
    char *tail;
    errno = 0;
    float value = strtof(text, &tail);
    if (tail == text || errno == ERANGE || !isfinite(value)) return -1;
    *result = value;
    *end = tail;
    return 0;
}

int lv_config_set(LVConfig *config, size_t field, const char *value, int *clamped) {
    if (clamped) *clamped = 0;
    if (!config || !value || field >= LV_CONFIG_FIELD_COUNT || strlen(value) >= 512) return -1;
    char buffer[512];
    memcpy(buffer, value, strlen(value) + 1);
    char *v = trim(buffer);
    const LVField *spec = &lv_fields[field];
    float result[4] = {0};
    if (spec->type == LV_BOOL) {
        if (!strcmp(v, "1") || !strcmp(v, "true")) result[0] = 1;
        else if (strcmp(v, "0") && strcmp(v, "false")) return -1;
    } else if (spec->type == LV_INT) {
        char *tail;
        errno = 0;
        long n = strtol(v, &tail, 10);
        if (tail == v || *trim(tail) || errno == ERANGE || n < INT_MIN || n > INT_MAX) return -1;
        result[0] = (float)n;
    } else if (spec->type == LV_FLOAT) {
        const char *tail;
        if (parse_float(v, result, &tail) || *trim((char *)tail)) return -1;
    } else {
        const char *cursor = v;
        for (int c = 0; c < 4; ++c) {
            const char *tail;
            if (parse_float(cursor, &result[c], &tail)) return -1;
            tail = trim((char *)tail);
            if (c < 3) {
                if (*tail != ',') return -1;
                cursor = tail + 1;
            } else if (*tail) return -1;
        }
    }
    if (spec->has_bounds) {
        float before = result[0];
        result[0] = fminf(spec->maximum, fmaxf(spec->minimum, result[0]));
        if (clamped && before != result[0]) *clamped = 1;
    }
    // Verified explicit fallback at Android 0x427cfc..0x427d1c.
    if (!strcmp(spec->key, "smiteHealthThreshold") &&
        result[0] != 600 && result[0] != 1000 && result[0] != 1400) {
        result[0] = 1000;
        if (clamped) *clamped = 1;
    }
    memcpy(config->values[field], result, sizeof(result));
    return 0;
}

int lv_config_parse(LVConfig *config, const char *text, LVParseReport *report) {
    LVParseReport r = {0};
    if (!config || !text || strnlen(text, LV_CONFIG_MAX_INPUT + 1) > LV_CONFIG_MAX_INPUT) {
        r.invalid = 1;
        if (report) *report = r;
        return -1;
    }
    char *copy = strdup(text);
    if (!copy) {
        r.invalid = 1;
        if (report) *report = r;
        return -1;
    }
    LVConfig candidate = *config;
    char *cursor = copy;
    while (cursor) {
        char *next = strchr(cursor, '\n');
        if (next) *next++ = 0;
        char *line = trim(cursor);
        cursor = next;
        if (!*line || *line == '#' || *line == ';') continue;
        char *eq = strchr(line, '=');
        if (!eq) { ++r.invalid; continue; }
        *eq++ = 0;
        char *key = trim(line), *v = trim(eq);
        if (!strcmp(key, "version")) {
            if (strcmp(v, "1")) r.unsupported_version = 1;
            continue;
        }
        int index = lv_config_index(key);
        if (index < 0) { ++r.unknown; continue; }
        int clamped = 0;
        if (lv_config_set(&candidate, (size_t)index, v, &clamped)) ++r.invalid;
        else { ++r.recognized; r.clamped += clamped; }
    }
    free(copy);
    if (report) *report = r;
    if (r.invalid || r.unsupported_version) return -1;
    *config = candidate;
    return 0;
}

static void append(char *out, size_t cap, size_t *used, const char *text) {
    size_t n = strlen(text);
    if (out && cap && *used < cap - 1) {
        size_t room = cap - 1 - *used;
        size_t count = n < room ? n : room;
        memcpy(out + *used, text, count);
    }
    *used += n;
}

size_t lv_config_serialize(const LVConfig *config, char *output, size_t capacity) {
    if (!config) return 0;
    size_t used = 0;
    append(output, capacity, &used, "version=1\n");
    for (size_t i = 0; i < LV_CONFIG_FIELD_COUNT; ++i) {
        const LVField *f = &lv_fields[i];
        const float *v = config->values[i];
        char line[512];
        if (f->type == LV_BOOL || f->type == LV_INT)
            snprintf(line, sizeof(line), "%s=%d\n", f->key, (int)v[0]);
        else if (f->type == LV_FLOAT)
            snprintf(line, sizeof(line), "%s=%.4f\n", f->key, (double)v[0]);
        else
            snprintf(line, sizeof(line), "%s=%.4f,%.4f,%.4f,%.4f\n", f->key,
                     (double)v[0], (double)v[1], (double)v[2], (double)v[3]);
        append(output, capacity, &used, line);
    }
    if (output && capacity) output[used < capacity ? used : capacity - 1] = 0;
    return used + 1;
}
