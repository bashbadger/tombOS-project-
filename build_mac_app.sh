#!/usr/bin/env bash
set -e

echo "=========================================="
echo "🚀 Building Tomb OS Native macOS Desktop App"
echo "=========================================="

if [ ! -d "node_modules/electron" ]; then
  echo "[+] Installing Electron desktop runner..."
  npm install --save-dev electron
fi

echo "[+] Launching Tomb OS Native Desktop Application..."
npx electron electron/main.js &

echo "[+] Native desktop application launched successfully."
