# Tomb OS: Hardened Security Simulator & Bootable Kernel Core

Welcome to **Tomb OS**, a dual-layer security research operating system and high-fidelity desktop virtualization simulator. This project includes a physical bootable C/Assembly kernel that runs on bare metal, coupled with a web-based GNOME Desktop simulator showcasing advanced mandatory access controls, zero-trust segmentation, real-time IDS network translation, and Qubes-style VM border isolation.

---

## 📂 Project Structure

```
tomb-os/
├── index.html         # GNOME desktop simulator markup
├── style.css          # Premium color system, glassmorphism, responsive zones
├── app.js             # Window manager, hypervisor engine, updates daemon
├── package.json       # Vite dev server and project configurations
├── .gitignore         # Ignores local packages and built artifacts
└── kernel/            # Physical bare-metal x86 source files
    ├── boot.asm       # Multiboot assembly bootloader
    ├── kernel.c       # Core C kernel printing VGA banner
    ├── linker.ld      # Physical memory section mapper
    ├── build.sh       # Dependency checks helper script
    └── Makefile       # Assembly compilation and QEMU run rules
```

---

## 🌐 Layer 1: GNOME Desktop Simulator (Web)

The web dashboard simulates **Tomb OS 1.0 LTS** under GNOME, optimized for both desktop browsers and touch-target mobile viewports.

### Features
1. **Qubes-style VM Borders**: Every application window is sandboxed inside a colored VM zone (Red/Untrusted, Yellow/Work, Blue/Personal, Green/Secure). Cross-zone data sharing triggers Xen Hypervisor administrator interception alerts.
2. **E2EE Remote Terminal Control**: Run `ssh-e2ee [remote_ip]` in the terminal to establish an end-to-end encrypted remote control session using quantum-resistant key exchanges.
3. **150-Character Interaction Hashes**: Every system transaction (compiling movies, remote command outputs, rules submission, and upgrades) generates and displays a unique 150-character alphanumeric integrity hash.
4. **OSS Auto-Upgrades Daemon**: Toggling the OSS updates module in the *Ultimate Hardening Center* starts a background updater that pulls, compiles, and verifies new AppArmor profiles, Suricata rules, and seL4 proofs.
5. **Interactive Agent Teacher**: Train your OS agent by writing automation rules which are dynamically saved and indexed in the brain log.

### How to Run Locally

Install the developer server dependencies:
```bash
npm install
```

Start the Vite network server:
```bash
npm run dev
```

### 📱 Testing from your Phone
Vite will serve the app on your local Wi-Fi network and print a network endpoint:
```
➜  Local:   http://localhost:5173/
➜  Network: http://192.168.1.50:5173/
```
Ensure your phone is connected to the same Wi-Fi network, type the `Network` URL in your **Safari (iOS) or Chrome (Android) tab**, and interact with the touch-responsive desktop workspace!

---

## 💻 Layer 2: Bootable x86 Minimal Kernel (Bare Metal)

Located in the `kernel/` folder, this is a real-world C/Assembly OS kernel that boots directly on bare-metal virtual hardware and writes to standard VGA memory.

### Step 1: Install Build Toolchains
On macOS, install the assembler, cross-compiler, and emulator using Homebrew:
```bash
brew install nasm i386-elf-gcc qemu
```

### Step 2: Compile the Binaries
Assemble `boot.asm` and compile `kernel.c` into a physical ELF executable:
```bash
cd kernel
make
```

### Step 3: Run inside virtual QEMU
Launch the compiled kernel directly inside a virtual x86 machine environment:
```bash
make run
```

### Step 4: Build a Bootable VM Disk Image (.ISO)
To generate a standard bootable ISO image (`tomb-os.iso`) that you can mount in **UTM**, **VirtualBox**, or **VMware**:
```bash
make iso
```
*(Requires `grub-mkrescue` and `xorriso` packages installed on your host).*
