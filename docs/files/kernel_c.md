# 💻 File Wiki: kernel/kernel.c

## Overview
`kernel/kernel.c` is the core 64-bit C microkernel entry point for bare-metal Tomb OS installations. It implements the primary boot routines (`kmain()`), memory paging descriptors, interrupt handlers, and low-level hardware audit logging.

## Core Functions & Kernel Subsystems

### 1. Boot Routines (`kmain()`)
- Initializes Global Descriptor Tables (GDT) and Interrupt Descriptor Tables (IDT).
- Sets up physical page frame allocators for system RAM.

### 2. Hardened Kernel Defenses
- Enforces Control Flow Integrity (CFI) and stack canary guard verification.
- Activates Kernel Page Table Isolation (KPTI) and KASLR entropy randomization.
- Mounts root filesystem overlay `/` as read-only (`IMMUTABLE`).

---
*Back to [Master Technical Wiki](../WIKI.md)*
