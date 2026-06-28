# ⚡ File Wiki: kernel/sel4_ipc.c & sel4_ipc.h

## Overview
`sel4_ipc.c` and its header `sel4_ipc.h` implement seL4-inspired capability-based access control gates for inter-process communication (IPC). This subsystem guarantees mathematical isolation between kernel tasks and user domains.

## Key Mechanics
- **Capability Routing**: Verifies explicit access tokens before granting IPC message transfer between tasks.
- **Synchronous Rendezvous**: Prevents covert timing channels and buffer leaks during inter-domain communication.

---
*Back to [Master Technical Wiki](../WIKI.md)*
