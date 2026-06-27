#!/usr/bin/env bash
set -e

# Build the kernel and create ISO
./kernel/build.sh

# Build Universal GrapheneOS (GSI) with tombOS integrations
./scripts/build_graphene.sh

# Package the ISO into a ZIP (and copy to iCloud if ICLOUD_DIR is set)
./scripts/package.sh

# Optional flashing to SDXC if FLASH_DEVICE is set (e.g., /dev/disk2)
if [[ -n "$FLASH_DEVICE" ]]; then
  echo "[+] Flashing ISO to $FLASH_DEVICE..."
  ./scripts/flash_sdxc.sh "$FLASH_DEVICE" "tombos_secure_amd64.iso"
fi

echo "[+] Build, package, and optional flash complete."
