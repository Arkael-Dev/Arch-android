# 🐧 Ubuntu GNOME on Android

<p align="center">
  <b>Ubuntu Linux + GNOME Desktop running on Android through Termux & Droidspaces.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Ubuntu-22.04-orange?style=for-the-badge&logo=ubuntu" alt="Ubuntu 22.04">
  <img src="https://img.shields.io/badge/GNOME-Desktop-blue?style=for-the-badge&logo=gnome" alt="GNOME">
  <img src="https://img.shields.io/badge/Termux-supported-black?style=for-the-badge&logo=termux" alt="Termux">
  <img src="https://img.shields.io/badge/Root-required-red?style=for-the-badge&logo=android" alt="Root Required">
</p>

---

## 🚀 About

**Ubuntu GNOME on Android** is an installer for running an Ubuntu Linux desktop environment with **GNOME** on Android using **Termux** and **Droidspaces**.

> 🖥️ Full GNOME desktop experience running directly on Android.

---

## ⚙️ Requirements

- 📱 Android device
- 🔓 Root access is required
- 🐧 Kernel must support **Droidspaces**
- 📦 **Droidspaces** installed
- 💻 **Termux** installed
- 👤 Container hostname: `ark`
- 👤 Container username: `ark`

---

## 📦 Droidspaces Setup

Open the **Droidspaces** application and look for the Ubuntu Rootfs.

**Rootfs Repository → Ubuntu 22.04 Server ARM64**

Your device must be rooted, and your kernel must support **Droidspaces**.

You must use **`ark`** as both the container hostname and username in Droidspaces.

---

## 📥 GNOME Rootfs

Download the Ubuntu 22.04 ARM64 rootfs:

https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-arm64-root.tar.xz

Use this rootfs with **Droidspaces** before running the installer.

---

## 🛠️ Installation

Run the following commands in **regular Termux**.

> ℹ️ This setup is designed to be started from regular Termux, not directly from Termux:X11.

### 1. Update Termux
storage termux
```
termux-setup-storage
```
```
pkg update && pkg upgrade -y
pkg install x11-repo -y
pkg update
pkg install termux-x11-nightly pulseaudio virglrenderer-android dbus -y
```

### 2. PulseAudio Fix

If required, run:

```bash
sed -i 's/module-sles-sink/module-aaudio-sink/g' "$PREFIX/etc/pulse/default.pa"
```

### 3. Run the Installer

```bash
pkg install wget -y && wget https://raw.githubusercontent.com/Arkael-Dev/linux-termux/refs/heads/ubuntu-gnome/setup.sh && chmod +x setup.sh && ./setup.sh
```

---

## 🖥️ Desktop Environment

This project uses:

```text
Ubuntu Linux
     │
     ├── GNOME Desktop
     │
     ├── Termux
     │
     ├── Droidspaces
     │
     └── Termux:X11
```

> 🎨 GNOME provides a modern full desktop experience on Android.

---

## ⚠️ Important

> [!IMPORTANT]
> Your device must already be rooted, and the kernel must support **Droidspaces**.

> [!NOTE]
> ⏳ The installation may take several minutes, depending on your internet connection.

> [!WARNING]
> Make sure the Droidspaces container hostname and username are both set to **`ark`**.

---

## 📥 Downloads

### Ubuntu GNOME Rootfs

[![Ubuntu Rootfs](https://img.shields.io/badge/Download-Ubuntu%2022.04%20ARM64-orange?style=for-the-badge&logo=ubuntu)](https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-arm64-root.tar.xz)

### Termux:X11

[![Termux:X11](https://img.shields.io/badge/Download-Termux%3AX11-black?style=for-the-badge&logo=github)](https://github.com/termux/termux-x11)

### Droidspaces

[![Droidspaces](https://img.shields.io/badge/Download-Droidspaces-blue?style=for-the-badge&logo=github)](https://github.com/ravindu644/Droidspaces-OSS)

---

## ⭐ Project

**Ubuntu GNOME on Android**

Made by **Arkael**

> 🐧 Ubuntu + GNOME + Android + Termux + Droidspaces
>
> **A modern Linux desktop experience on Android.**
