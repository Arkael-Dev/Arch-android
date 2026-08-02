# 🖥️ Termux XFCE4 on Android

<p align="center">
  <b>XFCE4 Desktop running on Android through Termux and Termux:X11.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Termux-XFCE4-black?style=for-the-badge&logo=termux" alt="Termux XFCE4">
  <img src="https://img.shields.io/badge/XFCE4-Desktop-blue?style=for-the-badge&logo=xfce" alt="XFCE4">
  <img src="https://img.shields.io/badge/Termux%3AX11-supported-black?style=for-the-badge&logo=x11" alt="Termux:X11">
  <img src="https://img.shields.io/badge/Android-supported-green?style=for-the-badge&logo=android" alt="Android">
</p>

---

## 🚀 About

**Termux XFCE4 on Android** is an automatic installer for running an **XFCE4 desktop environment** on Android through **Termux** and **Termux:X11**.

> Lightweight XFCE4 desktop environment designed for running Linux on Android.

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

    pkg install wget -y && wget https://raw.githubusercontent.com/Arkael-Dev/linux-termux/refs/heads/termux-exfce/setup.sh && chmod +x setup.sh && ./setup.sh

The installer will automatically install and configure the Termux XFCE4 environment.

After the installation is finished, start XFCE4 by typing this command in **regular Termux**:

    arkael

The XFCE4 desktop will start automatically through **Termux:X11**.

---

## ▶️ Start XFCE4 Again

After the installation is finished, you do not need to run the installer again.

Whenever you want to start XFCE4 again, open **regular Termux** and type:

    arkael

The XFCE4 desktop will start again through **Termux:X11**.

---

## 🛑 Exit XFCE4

When you want to exit the XFCE4 desktop, go to **regular Termux**.

Press:

    CTRL + C

Then type:

    exit

You can also simply **close the Termux popup**.

After exiting or closing Termux, open **regular Termux** again and type:

    arkael

XFCE4 will start again.

---

Manual installer command [here](https://github.com/Arkael-Dev/portable-pc)
## 📦 Install Apps in Termux XFCE4

To search for an available app:

    pkg search app-name

To install an app:

    pkg install app-name

---

## 🖥️ Desktop Environment

    Android
       │
       └── Termux
             │
             ├── XFCE4 Desktop
             │
             └── Termux:X11

> XFCE4 provides a lightweight desktop experience on Android.

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
> After installation, use `arkael` to start XFCE4 again.

> [!TIP]
> After exiting XFCE4, open Termux again and type `arkael`.

> [!WARNING]
> Do not run the installation command again if the environment has already been installed. Use `arkael` instead.

---

## 📥 Downloads

### Termux

[![Termux](https://img.shields.io/badge/Download-Termux-black?style=for-the-badge&logo=termux)](https://github.com/termux/termux-app)

### Termux:X11

[![Termux:X11](https://img.shields.io/badge/Download-Termux%3AX11-black?style=for-the-badge&logo=x11)](https://github.com/termux/termux-x11)

---

## 🔧 Auto Installer

The automatic installer is located in the `termux-exfce` branch.

### First Installation

Run this command only for the first installation:

    pkg install wget -y && wget https://raw.githubusercontent.com/Arkael-Dev/linux-termux/refs/heads/termux-exfce/setup.sh && chmod +x setup.sh && ./setup.sh

### Start After Installation

Every time you want to start XFCE4 again, simply run:

    arkael

---

## 📂 Project Structure

    linux-termux/
    │
    └── termux-exfce/
        │
        └── setup.sh

---

## ⭐ Project

**Termux XFCE4 on Android**

Made by **Arkael**

> XFCE4 + Android + Termux + Termux:X11

> A lightweight XFCE4 desktop experience running on Android.
