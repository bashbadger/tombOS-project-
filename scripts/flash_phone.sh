#!/usr/bin/env bash
set -e

# flash_phone.sh
# Usage: ./flash_phone.sh [SYSTEM_IMG_PATH]

IMG_PATH="${1:-system.img}"

if [[ ! -f "$IMG_PATH" ]]; then
  echo "[-] System image not found: $IMG_PATH"
  exit 1
fi

echo "[+] Checking for fastboot..."
if ! command -v fastboot &> /dev/null; then
  echo "[-] Error: fastboot is not installed or not in PATH."
  echo "    You can install it with: apt-get install android-tools-fastboot (or brew install android-platform-tools)"
  exit 1
fi

echo "[+] Waiting for device in fastboot mode..."
echo "    Please reboot your phone into the bootloader (fastboot) mode."
fastboot wait-for-device

echo "[+] Flashing GSI to system partition..."
fastboot flash system "$IMG_PATH"

echo "[+] Rebooting device..."
fastboot reboot

echo "[+] Phone flash complete. Your Universal GrapheneOS + tombOS system is booting."
