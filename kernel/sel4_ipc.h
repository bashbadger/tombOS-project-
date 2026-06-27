// Tomb OS - seL4 Formally Verified Microkernel IPC Interface
#ifndef SEL4_IPC_H
#define SEL4_IPC_H

#define SEL4_EP_CAP 0x01
#define SEL4_NOTIFICATION_CAP 0x02

typedef unsigned long seL4_CPtr;
typedef unsigned long seL4_Word;

typedef struct {
    seL4_Word words[4];
} seL4_MessageInfo;

// seL4 System Call Primitives
void seL4_Yield(void);
void seL4_Send(seL4_CPtr dest, seL4_MessageInfo msgInfo);
seL4_MessageInfo seL4_Recv(seL4_CPtr src, seL4_Word* sender);
seL4_MessageInfo seL4_Call(seL4_CPtr dest, seL4_MessageInfo msgInfo);

#endif
