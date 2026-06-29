/*
 * Tomb OS Enterprise C Kernel SDK v1.0.0
 * Bare-metal Ring 0 header interface for driver developers and kernel modules.
 */

#ifndef TOMBOS_SDK_H
#define TOMBOS_SDK_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

// Kernel System Call Numbers
#define SYS_TOMB_RECALL     0x101
#define SYS_TOMB_LEARN      0x102
#define SYS_TOMB_PQC_ENCRYPT 0x103
#define SYS_TOMB_ZTNA_TUNNEL 0x104

// Memory Protection Flags
#define PROT_PQC_ENCRYPTED  0x4000
#define PROT_VOLATILE_SCRUB 0x8000

// Struct definitions for driver operations
typedef struct {
    int (*open)(const char* path, int flags);
    int (*close)(int fd);
    ssize_t (*read)(int fd, void* buf, size_t count);
    ssize_t (*write)(int fd, const void* buf, size_t count);
} tombos_driver_ops_t;

// Exported Kernel Functions
void k_log_event(int level, const char* message);
void* k_alloc_pqc_pages(size_t page_count);
int k_register_driver(const char* name, tombos_driver_ops_t* ops);

#ifdef __cplusplus
}
#endif

#endif // TOMBOS_SDK_H
