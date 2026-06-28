# 🖥️ File Wiki: electron/main.js

## Overview
`electron/main.js` acts as the main process entry point when Tomb OS is executed as a native desktop application on macOS using Electron. It initializes the native application lifecycle, manages BrowserWindow instances, and bridges WebAuthn hardware security keys.

## Architecture & Security Provisions

### 1. BrowserWindow Configuration
- Configures a frameless or custom-titled window loading `index.html`.
- Enforces strict process isolation: `nodeIntegration: false` and `contextIsolation: true` to prevent malicious web scripts from accessing the underlying host OS.

### 2. Hardware Security Attestation
- Intercepts WebAuthn requests to interface with macOS Touch ID, YubiKey NFC, and Titan FIDO2 hardware security keys.

---
*Back to [Master Technical Wiki](../WIKI.md)*
