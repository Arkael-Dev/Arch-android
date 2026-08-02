#!/bin/bash
# Define Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${MAGENTA}========================================${NC}"
echo -e "${CYAN}        ARKAEL TERMUX INSTALLER         ${NC}"
echo -e "${MAGENTA}========================================${NC}"

# 1. Update and Upgrade Packages
echo -e "${YELLOW}[+] Updating and upgrading packages...${NC}"
pkg update -y && pkg upgrade -y

# 2. Install Repositories
echo -e "${YELLOW}[+] Installing repositories...${NC}"
pkg install -y tur-repo
pkg install -y x11-repo

# 3. Install Required Packages & XFCE4
echo -e "${YELLOW}[+] Installing required packages and XFCE4 desktop...${NC}"
pkg install -y termux-x11-nightly pulseaudio wget git xfce4

# 4. Setup Storage Access (FIXED: auto 'y' so it doesn't hang)
echo -e "${YELLOW}[+] Setting up storage access...${NC}"
yes | termux-setup-storage

# 5. Create 'arkael' launcher script without nano
echo -e "${YELLOW}[+] Creating arkael launcher script...${NC}"
cat << 'EOF' > ~/arkael
#!/data/data/com.termux/files/usr/bin/bash

# ============================================================
# Native Termux XFCE4 Launch Script (No proot)
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
# Prevents gpg-agent "socket file removed - retrying binding" loop
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
# xrdb -merge writes it to the X Resource Database where GTK/Qt apps can read it.
# 144 DPI = 150% scaling (96 * 1.5 = 144)
xrdb -merge <<< "Xft.dpi: 144"

# GTK scaling
export GDK_SCALE=2
export GDK_DPI_SCALE=0.75
export XCURSOR_SIZE=40

# Disable GPU for QtWebEngine-based browsers (Falkon, etc.)
# Termux-X11 does not support GPU acceleration for Chromium's rendering pipeline.
export QTWEBENGINE_DISABLE_GPU=1
export QT_QUICK_BACKEND=software

# Run XFCE4 Desktop
# NOTE: We do NOT start dbus-daemon --system here.
# The D-Bus "Failed to connect to bus" warnings are non-fatal.
exec dbus-launch --exit-with-session xfce4-session
EOF

# 6. Make the 'arkael' script executable
echo -e "${YELLOW}[+] Setting executable permissions...${NC}"
chmod +x ~/arkael

# 7. Create alias in .bashrc without changing default Termux look
echo -e "${YELLOW}[+] Configuring .bashrc with alias...${NC}"

# FIXED: Create .bashrc if it doesn't exist to prevent grep error
touch ~/.bashrc

# Add alias if it doesn't exist (Without welcome messages or PS1 changes)
if ! grep -q "alias arkael=" ~/.bashrc; then
    echo 'alias arkael="~/arkael"' >> ~/.bashrc
fi

# 8. Reload configuration
source ~/.bashrc

# 9. Create Shutdown shortcut on Desktop without nano
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

echo -e "${MAGENTA}========================================${NC}"
echo -e "${GREEN}         INSTALLATION COMPLETE!         ${NC}"
echo -e "${MAGENTA}========================================${NC}"
echo -e "${CYAN}To launch the portable PC desktop, type:${NC} ${YELLOW}arkael${NC}"
