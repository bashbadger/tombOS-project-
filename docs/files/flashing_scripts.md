# ⚡ File Wiki: Deployment & Flashing Scripts

## Overview
This suite of shell scripts handles cross-platform installation and device flashing:
- `scripts/flash_phone.sh`: Flashes universal Project Treble GrapheneOS GSIs onto Android devices via Android Fastboot.
- `scripts/flash_sdxc.sh`: Raw disk `dd` utility for burning live bootable SD XC cards and external NVMe drives.
- `scripts/docker_run.sh`: Builds and executes hardened container environments.
- `scripts/build_graphene.sh` & `scripts/build_rootfs.sh`: Builds system images and CPIO initramfs archives.
- `install.sh`, `install.ps1`, `uninstall.sh`, `build_tombos.sh`: Cross-platform installation and setup tools.

---
*Back to [Master Technical Wiki](../WIKI.md)*
