#!/usr/bin/env bash
set -e

# flash_sdxc.sh
# Usage: ./flash_sdxc.sh <DEVICE> <ISO_PATH>
# Example: ./flash_sdxc.sh /dev/disk2 tombos_secure_amd64.iso

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <DEVICE> <ISO_PATH>"
  exit 1
fi

DEVICE="$1"
ISO_PATH="$2"

if [[ ! -f "$ISO_PATH" ]]; then
  echo "[-] ISO file not found: $ISO_PATH"
  exit 1
fi

echo "[+] Unmounting $DEVICE (if mounted)..."
# macOS unmount, ignore errors on Linux
if command -v diskutil &>/dev/null; then
  diskutil unmountDisk "$DEVICE" || true
fi

echo "[+] Writing ISO to $DEVICE using dd (this may take a while)..."
# Require sudo for raw device access
sudo dd if="$ISO_PATH" of="$DEVICE" bs=4M conv=sync,noerror status=progress

sync

echo "[+] Flash complete."
