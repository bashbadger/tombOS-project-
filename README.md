# Tomb OS: Hardened Security Simulator & Universal Mobile OS

Welcome to **Tomb OS**, a multi-layer project that provides:

1. **Layer 1: Desktop Simulator (Web)** – A modern web-based desktop simulator built with Vite + Electron.
2. **Layer 2: Bootable x86 Minimal Kernel** – A bare-metal x86 kernel (C/Assembly) that can be run in QEMU or built into a bootable ISO.
3. **Layer 3: Universal GrapheneOS Integration (GSI)** – A tightly integrated, automated build pipeline that compiles the Tomb OS kernel and injects it into a universal GrapheneOS Generic System Image (GSI) capable of running on *any* modern Android smartphone.

---

## 🚀 Getting Started

The entire build process is now fully containerised using Docker. You no longer need to install compilers, assemblers, or Android build tools on your host machine.

### Prerequisites
1. **Docker Desktop** (or Docker Engine) installed and running.
2. **make** (usually installed by default on macOS/Linux).
3. **fastboot** (if you plan to flash the image to a phone).

---

## 🛠️ Building the OS

To build the entire project (tombOS ISO + GrapheneOS GSI), simply run:

```bash
make build
```

**What this does under the hood:**
1. Builds a secure `tombos_builder` Docker container containing all necessary dependencies (`nasm`, `gcc`, Android `repo`, `openjdk-17`).
2. Compiles the **tombOS x86 Kernel** (`kernel.bin`) and packages it into `tombos_secure_amd64.iso`.
3. Downloads the Universal GrapheneOS source code.
4. Compiles the **GrapheneOS GSI (`system.img`)**, natively injecting tombOS hooks.
5. Packages everything into `GrapheneOS_tombOS_Universal_GSI.zip`.

*(Note: The Android GSI build downloads gigabytes of source code and compiles millions of lines. This process can take several hours depending on your internet and CPU speed.)*

---

## 📱 Flashing to a Smartphone

Because this project builds a **Generic System Image (GSI)**, it can be flashed onto *every phone* that supports Project Treble (virtually all modern Android devices).

1. Unlock your phone's bootloader.
2. Reboot your phone into `fastboot` mode.
3. Connect your phone via USB.
4. Run the universal flashing script:

```bash
./scripts/flash_phone.sh out/graphene_gsi/out/target/product/generic_arm64/system.img
```
The script will safely write the custom GrapheneOS + tombOS image to your phone's system partition and reboot it.

---

## 💾 Flashing to an SD XC Drive (x86 ISO)

If you want to flash the bare-metal x86 `tombos_secure_amd64.iso` to an external SD XC card for booting on a PC:

```bash
./scripts/flash_sdxc.sh /dev/diskX tombos_secure_amd64.iso
```
*(Replace `/dev/diskX` with the actual device node of your SD card. Be careful, as this will overwrite the drive!)*

You can also automate this during the build phase by running:
```bash
make build FLASH_DEVICE=/dev/diskX
```

---

## 📂 Project Structure

```
Tomb-OS/
├─ Makefile               # Main orchestration script (Docker build + run)
├─ Dockerfile             # Universal Build Environment (Debian + Android Tools)
├─ build_tombos.sh        # The master build script executed inside Docker
├─ kernel/                # Bare-metal x86 kernel source
│   ├─ boot.asm
│   ├─ kernel.c
│   └─ build.sh           # Kernel compilation steps
├─ scripts/
│   ├─ build_graphene.sh  # Downloads and builds the GrapheneOS GSI
│   ├─ flash_phone.sh     # Universal Android fastboot flasher
│   ├─ flash_sdxc.sh      # SD XC raw writing script
│   └─ package.sh         # Zips up the ISO and GSI images
├─ index.html             # Desktop simulator markup
├─ app.js                 # Core UI logic
└─ style.css              # Styling and layout
```

---

## 🙋 Contributing
- Fork the repo, create a feature branch, and submit a Pull Request.
- Enjoy building and exploring Tomb OS!
