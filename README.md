# Ubuntu XFCE4 on Android

Ubuntu Linux + XFCE4 installer for Termux.
how to install
open the droidspace application & look for the Rootfs Repository Ubuntu 24.04.04 LTS - XFCE
Run the command below in Termux:
This is the first time I've run this on regular termux, not termux x11.
```
pkg update && pkg upgrade -y
pkg install x11-repo -y
pkg install termux-x11-nightly pulseaudio virglrenderer-android -y
```
# or 
```
sed -i 's/module-sles-sink/module-aaudio-sink/g' "$PREFIX/etc/pulse/default.pa"
````
```bash
pkg install wget -y && wget https://raw.githubusercontent.com/Arkael-Dev/linux-termux/refs/heads/ubuntu-exfce/setup.sh && chmod +x setup.sh && ./setup.sh
```
>[!NOTE]
> ## «⏳ The installation may take several minutes, depending on your internet connection.»

Download
```
app [termux](https://github.com/termux/termux-x11)
```
```
app [droidspaces](https://github.com/ravindu644/Droidspaces-OSS)
```
```
Your device must already be rooted, and the kernel must support Droidspaces.
This Arkael project
```
