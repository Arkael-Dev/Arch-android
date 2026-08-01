# 🐧 Ubuntu XFCE4 on Android

<p align="center">
  <b>Ubuntu Linux + XFCE4 Desktop running on Android through Termux & Droidspaces.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Ubuntu-24.04-orange?style=for-the-badge&logo=ubuntu" alt="Ubuntu 24.04">
  <img src="https://img.shields.io/badge/XFCE4-Desktop-blue?style=for-the-badge&logo=xfce" alt="XFCE4">
  <img src="https://img.shields.io/badge/Termux-supported-black?style=for-the-badge&logo=termux" alt="Termux">
</p>

---

## 🚀 About

**Ubuntu XFCE4 on Android** is an installer for running an Ubuntu Linux desktop environment with **XFCE4** on Android using **Termux** and **Droidspaces**.

> ⚡ Lightweight XFCE4 desktop — no GNOME required.

---

## ⚙️ Requirements

- 📱 Android device
- 🔓 Root access is required
- 🐧 Kernel must support **Droidspaces**
- 📦 **Droidspaces** installed
- 💻 **Termux** installed
- 👤 Container hostname: `arkael`
- 👤 Container username: `arkael`

---

## 📦 Droidspaces Setup

Open the **Droidspaces** application and look for:

**Rootfs Repository → Ubuntu 24.04.04 LTS - XFCE**

Your device must be rooted, and your kernel must support **Droidspaces**.

You must use **`arkael`** as both the container hostname and username in Droidspaces.

---

## 🛠️ Installation

Run the following commands in **regular Termux**.

> ℹ️ This setup is designed to be started from regular Termux, not directly from Termux:X11.

### 1. Update Termux
termux stup storage :
```
termux-setup-storage
````
```
pkg update && pkg upgrade -y
pkg install x11-repo -y
pkg install termux-x11-nightly pulseaudio virglrenderer-android -y
```

### 2. PulseAudio Fix

If required, run:

```bash
sed -i 's/module-sles-sink/module-aaudio-sink/g' "$PREFIX/etc/pulse/default.pa"
```

### 3. Run the Installer

```bash
pkg install wget -y && wget https://raw.githubusercontent.com/Arkael-Dev/linux-termux/refs/heads/ubuntu-exfce/setup.sh && chmod +x setup.sh && ./setup.sh
```

---

## 🖥️ Desktop Environment

This project uses:

```text
Ubuntu Linux
     │
     ├── XFCE4 Desktop
     │
     ├── Termux
     │
     ├── Droidspaces
     │
     └── Termux:X11
```

> 🎨 XFCE4 is used instead of GNOME to provide a lighter desktop experience on Android.

---

## ⚠️ Important

> [!IMPORTANT]
> Your device must already be rooted, and the kernel must support **Droidspaces**.

> [!NOTE]
> ⏳ The installation may take several minutes, depending on your internet connection.

> [!WARNING]
> Make sure the Droidspaces container hostname and username are both set to **`arkael`**.

---

## 📥 Downloads

### Termux:X11

[![Termux:X11](https://img.shields.io/badge/Download-Termux%3AX11-black?style=for-the-badge&logo=github)](https://github.com/termux/termux-x11)

### Droidspaces

[![Droidspaces](https://img.shields.io/badge/Download-Droidspaces-blue?style=for-the-badge&logo=github)](https://github.com/ravindu644/Droidspaces-OSS)

---

## ⭐ Project

**Ubuntu XFCE4 on Android**

Made by **Arkael**

> 🐧 Ubuntu + XFCE4 + Android + Termux + Droidspaces
>
> **A lightweight Linux desktop experience on Android.**
