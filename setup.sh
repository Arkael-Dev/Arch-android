#!/bin/bash
pkg update -y
pkg upgrade -y
pkg install tur-repo -y
pkg install x11-repo -y
pkg install termux-x11-nightly -y
pkg install pulseaudio -y
pkg install wget -y
pkg install git -y
termux-setup-storage
pkg install xfce4 -y

cat > ~/arkael.sh << 'EOF'
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

chmod +x ~/arkael.sh
grep -q "alias arkael=" ~/.bashrc || echo "alias arkael='bash ~/arkael.sh'" >> ~/.bashrc
source ~/.bashrc

#run
arkael
