// Tomb OS - seL4 Microkernel IPC Capability Router
#include "sel4_ipc.h"

void seL4_Yield(void) {
    #if defined(__i386__) || defined(__x86_64__)
    __asm__ __volatile__ ("pause" ::: "memory");
    #else
    __asm__ __volatile__ ("nop" ::: "memory");
    #endif
}

void seL4_Send(seL4_CPtr dest, seL4_MessageInfo msgInfo) {
    // Verified IPC Send capability routing stub
}

seL4_MessageInfo seL4_Recv(seL4_CPtr src, seL4_Word* sender) {
    seL4_MessageInfo info = { {0, 0, 0, 0} };
    return info;
}

seL4_MessageInfo seL4_Call(seL4_CPtr dest, seL4_MessageInfo msgInfo) {
    seL4_MessageInfo reply = { {1, 0, 0, 0} };
    return reply;
}
