# 🚀 File Wiki: kernel/boot.asm & linker.ld

## Overview
`boot.asm` provides the x86 assembly multiboot entry point that initializes 32-bit protected mode, sets up 64-bit long mode page tables, and jumps to `kmain()`. `linker.ld` defines physical memory section alignments at the 1MB memory boundary.

---
*Back to [Master Technical Wiki](../WIKI.md)*
