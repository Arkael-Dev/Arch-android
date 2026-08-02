# 🐧 Arch Linux XFCE4 on Android

<p align="center">
  <b>Arch Linux + XFCE4 Desktop running on Android through Termux & Termux:X11.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-Latest-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white" alt="Arch Linux">
  <img src="https://img.shields.io/badge/XFCE4-Desktop-blue?style=for-the-badge&logo=xfce" alt="XFCE4">
  <img src="https://img.shields.io/badge/Termux-supported-black?style=for-the-badge&logo=termux" alt="Termux">
  <img src="https://img.shields.io/badge/Termux%3AX11-supported-black?style=for-the-badge&logo=x11" alt="Termux:X11">
</p>

---

## 🚀 About

**Arch Linux XFCE4 on Android** is an automatic installer for running an **Arch Linux desktop environment with XFCE4** on Android through **Termux** and **Termux:X11**.

> Lightweight XFCE4 desktop environment designed for running Arch Linux on Android.

---

## ⚙️ Requirements

- Android device
- **Termux** installed
- **Termux:X11** installed
- Internet connection
- Sufficient free storage
- Compatible Android device

> Root access is not required.

---

## 🛠️ Installation

Open **regular Termux** and run:

    pkg install wget -y && wget https://raw.githubusercontent.com/Arkael-Dev/linux-termux/refs/heads/Arch-linux-termux/setup.sh && chmod +x setup.sh && ./setup.sh

After the installation is finished, start Arch Linux XFCE4 by typing this command in **regular Termux**:

    arkael-arch

The Arch Linux XFCE4 desktop will start automatically through **Termux:X11**.

---

## 🛑 Exit Arch Linux XFCE4

When you want to exit the Arch Linux XFCE4 desktop, go to **regular Termux**.

Press:

    CTRL + C

Then type:

    exit

You can also simply **close the Termux popup**.

---

## 🔄 Start Arch Linux Again

After exiting Arch Linux or closing the Termux popup, open **regular Termux** again.

To start Arch Linux XFCE4 again, simply type:

    arkael-arch

The Arch Linux XFCE4 desktop will start again through **Termux:X11**.

You do **not** need to run the installation command again.

---

## 🖥️ Desktop Environment

    Arch Linux
         │
         ├── XFCE4 Desktop
         ├── Termux
         └── Termux:X11

> XFCE4 is used to provide a lightweight desktop experience on Android.

---

## 🔊 Audio

The desktop environment uses PulseAudio for audio.

Audio configuration is handled automatically by the installer.

---

## 🎮 Graphics

The desktop uses Termux:X11 for graphical output.

Graphics performance depends on your Android device, GPU, ROM, drivers, Mesa configuration, and Termux:X11 compatibility.

---

## ⚠️ Important

> [!IMPORTANT]
> Run the installation command from **regular Termux**.

> [!NOTE]
> The first installation may take some time depending on your internet connection and device performance.

> [!NOTE]
> After installation, use `arkael-arch` to start Arch Linux XFCE4.

> [!TIP]
> After exiting Arch Linux, open Termux again and type `arkael-arch`.

---
fixed storage Arch Linux after install
closed dekstop XFCE4 and run termux👇
```
termux-setup-storage && \
echo "[+] Termux storage fixed." && \
echo "[+] Checking Android storage..." && \
ls -lah ~/storage/shared
```
## 📥 Downloads

### Termux

[![Termux](https://img.shields.io/badge/Download-Termux-black?style=for-the-badge&logo=termux)](https://github.com/termux/termux-app)

### Termux:X11

[![Termux:X11](https://img.shields.io/badge/Download-Termux%3AX11-black?style=for-the-badge&logo=x11)](https://github.com/termux/termux-x11)

---

## ⭐ Project

**Arch Linux XFCE4 on Android**

Made by **Arkael**

> Arch Linux + XFCE4 + Android + Termux + Termux:X11

> A lightweight Linux desktop experience running on Android.
