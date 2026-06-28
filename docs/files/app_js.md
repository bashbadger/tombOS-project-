# ⚙️ File Wiki: app.js

## Overview
`app.js` is the central orchestrator and master JavaScript logic engine for Tomb OS. It manages the global state machine (`systemState`), dynamic window creation and z-index focusing, terminal CLI command parsing, micro-VM hypervisor dispatcher, and all enterprise feature modules.

## Major Subsystems & Engine Modules

### 1. Global State Machine (`systemState`)
Tracks real-time telemetry across all modules:
- `activeTaskIp`: Dynamic rolling egress IP address assigned to active tasks.
- `securityModules`: Independent state toggles for ZTNA, DLP, PQC, RASP, IAM, and EDR enclaves.
- `typeSpeed`: Optional WPM, keystroke accuracy %, and ergonomics cadence metrics.
- `taskRecorder`: Live macro step capture array and saved AI auto-pilot workflows.
- `features`: Live status for UFW firewall, AppArmor MAC, Auditd, Fail2ban, and IDS.

### 2. Hardened Terminal CLI Parser (`handleTerminalCommand`)
Parses administrative commands executed in the shell:
- System diagnostics: `ufw`, `aa-status`, `audit`, `ids-log`, `sysinfo`.
- Security tools: `cis-audit`, `soc2-check`, `pqc-encrypt`, `vault`.
- OpenAI Intelligence: `openai [query]` and `gpt` terminal integration.

### 3. Disposable Hypervisor Dispatcher (`getBrowserContent`)
Allocates dedicated Xen DomU micro-VM containers (`DomU-VM-XXXXX`) for every open Chromium browser window. Automatically triggers volatile 512MB RAM scrubbing on window close.

### 4. Automated Task & Threat Engines
- **Dynamic Task IP Rotator (`rotateTaskIp`)**: Recalculates egress IPs automatically on every action.
- **AI Task Recorder (`recordTaskStep`)**: Captures steps while scrubbing passphrases and tokens via regex DLP.
- **Web Upload Sanitizer (`uploadAndSanitizeWebFile`)**: Intercepts web uploads, neutralizes VBA macros, and scrubs EXIF metadata.

---
*Back to [Master Technical Wiki](../WIKI.md)*
