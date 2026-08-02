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

```bash
pkg install wget -y && wget https://raw.githubusercontent.com/Arkael-Dev/linux-termux/refs/heads/Arch-linux-termux/setup.sh && chmod +x setup.sh && ./setup.sh
