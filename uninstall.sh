#!/usr/bin/env bash
# Exit on error
set -e

# Determine install prefix (must match install.sh)
PREFIX="/usr/local"
TARGET_DIR="$PREFIX/share/tomb-os"
BIN_DIR="$PREFIX/bin"

# Stop the systemd service if present
if [[ -f /run/systemd/system ]]; then
  sudo systemctl stop tomb-os.service || true
  sudo systemctl disable tomb-os.service || true
  sudo rm -f /etc/systemd/system/tomb-os.service
  sudo systemctl daemon-reload || true
fi

# Unload macOS launchd plist if present
if [[ "$OSTYPE" == "darwin"* ]]; then
  PLIST="$HOME/Library/LaunchAgents/com.tombos.server.plist"
  if [[ -f "$PLIST" ]]; then
    launchctl unload "$PLIST" || true
    rm -f "$PLIST"
  fi
fi

# Remove wrapper script and installed files
sudo rm -f "$BIN_DIR/tomb-os"
sudo rm -rf "$TARGET_DIR"

echo "Uninstallation complete. Tomb‑OS has been removed."
