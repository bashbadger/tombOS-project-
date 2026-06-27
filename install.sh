#!/usr/bin/env bash
# Exit on error
set -e

# Determine install prefix
PREFIX="/usr/local"
TARGET_DIR="$PREFIX/share/tomb-os"
BIN_DIR="$PREFIX/bin"

# Ensure Node.js is available via portable runtime
echo "Setting up portable Node.js runtime..."
PORTABLE_NODE_DIR="$(dirname "$0")/node_runtime"
if [ -x "$PORTABLE_NODE_DIR/bin/node" ]; then
  export PATH="$PORTABLE_NODE_DIR/bin:$PATH"
  echo "Using bundled Node.js from $PORTABLE_NODE_DIR"
else
  echo "Downloading portable Node.js..."
  OS=$(uname -s)
  ARCH=$(uname -m)
  case "$OS" in
    Linux) NODE_URL="https://nodejs.org/dist/v20.11.0/node-v20.11.0-linux-$ARCH.tar.xz" ;;
    Darwin) NODE_URL="https://nodejs.org/dist/v20.11.0/node-v20.11.0-darwin-$ARCH.tar.gz" ;;
    *) echo "Unsupported OS: $OS" && exit 1 ;;
  esac
  mkdir -p "$PORTABLE_NODE_DIR"
  curl -L "$NODE_URL" -o /tmp/node.tar.xz
  tar -xf /tmp/node.tar.xz -C "$PORTABLE_NODE_DIR" --strip-components=1
  export PATH="$PORTABLE_NODE_DIR/bin:$PATH"
  echo "Portable Node.js installed to $PORTABLE_NODE_DIR"
fi

# Install serve globally
npm install -g serve

# Copy files
sudo mkdir -p "$TARGET_DIR"
sudo cp -r "$PWD"/* "$TARGET_DIR/"

# Create wrapper script
sudo tee "$BIN_DIR/tomb-os" > /dev/null <<'EOF'
#!/usr/bin/env bash
serve -s "$TARGET_DIR" -l 8080
EOF
sudo chmod +x "$BIN_DIR/tomb-os"

# Register systemd service (Linux only)
if [[ -f /run/systemd/system ]]; then
  SERVICE_FILE="/etc/systemd/system/tomb-os.service"
  sudo bash -c "cat > $SERVICE_FILE" <<EOL
[Unit]
Description=Tomb‑OS Hypervisor UI
After=network.target

[Service]
ExecStart=$BIN_DIR/tomb-os
Restart=always
User=root
Environment=PATH=/usr/local/bin:/usr/bin:/bin

[Install]
WantedBy=multi-user.target
EOL
  sudo systemctl daemon-reload
  sudo systemctl enable tomb-os.service
  sudo systemctl start tomb-os.service
fi

# macOS launchd plist (optional)
if [[ "$OSTYPE" == "darwin"* ]]; then
  PLIST="$HOME/Library/LaunchAgents/com.tombos.server.plist"
  cat > "$PLIST" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.tombos.server</string>
  <key>ProgramArguments</key><array><string>$BIN_DIR/tomb-os</string></array>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
</dict>
</plist>
EOL
  launchctl load "$PLIST"
fi

echo "Installation complete. Access the UI at http://localhost:8080"
