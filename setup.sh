#!/data/data/com.termux/files/usr/bin/bash

# Define Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${MAGENTA}========================================${NC}"
echo -e "${CYAN} ARKAEL ARCH LINUX XFCE4 AUTO INSTALLER ${NC}"
echo -e "${MAGENTA}========================================${NC}"

# 1. Update and Upgrade Packages
echo -e "${YELLOW}[+] Updating and upgrading Termux packages...${NC}"
pkg update -y && pkg upgrade -y

# 2. Install Required Packages (Fixed order: x11-repo before termux-x11)
echo -e "${YELLOW}[+] Installing Termux dependencies...${NC}"
pkg install -y x11-repo
pkg install -y termux-x11-nightly pulseaudio virglrenderer-android
pkg install -y proot-distro wget git

# 3. Setup Storage Access
echo -e "${YELLOW}[+] Setting up storage access...${NC}"
yes | termux-setup-storage

# 4. Install Arch Linux
echo -e "${YELLOW}[+] Installing Arch Linux ARM via proot-distro...${NC}"
proot-distro install danhunsaker/archlinuxarm:20260726

# 5. Configure Arch Linux
echo -e "${YELLOW}[+] Configuring Arch Linux (pacman, xfce4, user Arkael)...${NC}"
proot-distro login archlinuxarm -- bash -c "
sed -i 's/^#DownloadUser = alpm/DownloadUser = alpm/' /etc/pacman.conf
mv /usr/bin/pacman /usr/bin/pacman-real
echo '#!/bin/bash' > /usr/bin/pacman
echo '/usr/bin/pacman-real --disable-sandbox \"\$@\"' >> /usr/bin/pacman
chmod +x /usr/bin/pacman
pacman -Sy
echo -e '1\ny' | pacman -Syu
pacman -S --needed --noconfirm xfce4
pacman -S --noconfirm sudo
useradd -m -G wheel Arkael
echo 'Arkael:1234' | chpasswd
sed -i '/^root ALL=(ALL:ALL) ALL\$/a Arkael ALL=(ALL:ALL) ALL' /etc/sudoers"

# 6. Create 'arkael-arch' launcher script without nano
echo -e "${YELLOW}[+] Creating arkael-arch launcher script...${NC}"
cat << 'EOF' > ~/arkael-arch
#!/data/data/com.termux/files/usr/bin/bash

# ============================================================
# Arkael Arch Linux XFCE4 Launch Script (proot)
# Includes DPI scaling, GPU workarounds, and stale file cleanup
# ============================================================

# Kill leftover processes
pkill -9 -f "termux.x11" 2>/dev/null
pkill -9 -f "xfce4-session" 2>/dev/null
pkill -9 -f "pulseaudio" 2>/dev/null
pkill -9 -f "dbus-launch" 2>/dev/null
pkill -9 -f "dbus-daemon" 2>/dev/null

sleep 2

# Clean up stale PID files and sockets from previous sessions
rm -f /data/data/com.termux/files/usr/var/run/dbus/pid
gpgconf --kill gpg-agent 2>/dev/null

# Ensure sdcard symlinks exist
if [ ! -d "$HOME/storage" ]; then
    termux-setup-storage
fi

# Start PulseAudio
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

sleep 1

# Start X server
export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

sleep 3

# Launch Termux:X11 app
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1

sleep 1

# Set environment variables
export DISPLAY=:0
export PULSE_SERVER=127.0.0.1

# Set DPI via xrdb instead of export
# 144 DPI = 150% scaling (96 * 1.5 = 144)
xrdb -merge <<< "Xft.dpi: 144"

# GTK scaling
export GDK_SCALE=2
export GDK_DPI_SCALE=0.75
export XCURSOR_SIZE=40

# Disable GPU for QtWebEngine-based browsers
export QTWEBENGINE_DISABLE_GPU=1
export QT_QUICK_BACKEND=software

# Run XFCE4 Desktop inside Arch Linux proot
# NOTE: The D-Bus warnings are non-fatal.
proot-distro login archlinuxarm --user Arkael --shared-tmp --bind /dev/null:/proc/sys/kernel/cap_last_last -- bash -c "export DISPLAY=:0; export PULSE_SERVER=127.0.0.1; export GDK_SCALE=2; export GDK_DPI_SCALE=0.75; export XCURSOR_SIZE=40; export QTWEBENGINE_DISABLE_GPU=1; export QT_QUICK_BACKEND=software; dbus-launch --exit-with-session xfce4-session"
EOF

# 7. Make the 'arkael-arch' script executable
echo -e "${YELLOW}[+] Setting executable permissions...${NC}"
chmod +x ~/arkael-arch

# 8. Configure PATH so 'arkael-arch' can be executed directly
echo -e "${YELLOW}[+] Configuring PATH...${NC}"
touch ~/.bashrc

# Add HOME to PATH if it doesn't exist
if ! grep -q 'export PATH="$HOME:$PATH"' ~/.bashrc; then
    echo 'export PATH="$HOME:$PATH"' >> ~/.bashrc
fi

# Apply PATH immediately
export PATH="$HOME:$PATH"
hash -r

# 9. Reload configuration
source ~/.bashrc
export PATH="$HOME:$PATH"
hash -r

# 10. Create Shutdown shortcut on Desktop without nano
echo -e "${YELLOW}[+] Creating Shutdown shortcut...${NC}"
mkdir -p ~/Desktop
cat << 'EOF' > ~/Desktop/shutdown.desktop
[Desktop Entry]
Type=Application
Name=Shutdown
# Comment=Close Termux:X11 session
# Exec: the command to run — kills the X server and session
Exec=sh -c "current_pid=$$; pids=$(pgrep -f 'termux.x11' | grep -v $current_pid); if [ -n \"$pids\" ]; then kill -9 $pids; fi"
Icon=xfsm-shutdown
Terminal=true
Categories=System;
Path=
StartupNotify=false
EOF

# Copy shutdown shortcut to Arch Linux user Desktop so it appears in XFCE4
ARCH_HOME="/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/archlinuxarm/home/Arkael"
mkdir -p "$ARCH_HOME/Desktop"
cp ~/Desktop/shutdown.desktop "$ARCH_HOME/Desktop/"

echo -e "${MAGENTA}========================================${NC}"
echo -e "${GREEN}         INSTALLATION COMPLETE!         ${NC}"
echo -e "${MAGENTA}========================================${NC}"
echo -e "${CYAN}To launch the Arch Linux desktop, type:${NC} ${YELLOW}arkael-arch${NC}"
