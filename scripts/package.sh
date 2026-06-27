#!/usr/bin/env bash
set -e

ISO_PATH="tombos_secure_amd64.iso"
GSI_PATH="system.img"
ZIP_NAME="GrapheneOS_tombOS_Universal_GSI.zip"

if [[ ! -f "$ISO_PATH" ]]; then
  echo "[-] ISO file not found: $ISO_PATH"
  exit 1
fi

if [[ ! -f "$GSI_PATH" ]]; then
  echo "[-] GSI system.img not found: $GSI_PATH (Did the GrapheneOS build fail?)"
  exit 1
fi

# Create a ZIP containing the ISO, GSI, scripts, and documentation
zip -r "$ZIP_NAME" "$ISO_PATH" "$GSI_PATH" scripts/flash_phone.sh scripts/flash_sdxc.sh README.md

echo "[+] Package created: $ZIP_NAME"

# If ICLOUD_DIR is defined, copy the zip there
if [[ -n "$ICLOUD_DIR" ]]; then
  cp "$ZIP_NAME" "$ICLOUD_DIR/"
  echo "[+] Copied $ZIP_NAME to iCloud folder: $ICLOUD_DIR"
fi
