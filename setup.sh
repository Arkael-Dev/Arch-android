#!/bin/sh

# ============================================================
# Droidspaces + Termux:X11 + PulseAudio + XFCE Setup
# Container: arkael
# Display: :5
# ============================================================

# 1. Force-stop Termux:X11, PulseAudio, and stop the container
su -c "am force-stop com.termux.x11" 2>/dev/null

su -c "/data/local/Droidspaces/bin/droidspaces --name='arkael' stop" 2>/dev/null

pkill -9 termux-x11 Xorg virglrenderer pulseaudio 2>/dev/null

su -c "pkill -9 termux-x11 Xorg virglrenderer pulseaudio" 2>/dev/null

sleep 3


# 2. Clean old X11 lock files and sockets
su -c "rm -rf /data/data/com.termux/files/usr/tmp/.X5-lock \
/data/data/com.termux/files/usr/tmp/.X11-unix/X5" 2>/dev/null

rm -rf /data/data/com.termux/files/usr/tmp/.X5-lock \
/data/data/com.termux/files/usr/tmp/.X11-unix/X5 2>/dev/null

mkdir -p /data/data/com.termux/files/usr/tmp/.X11-unix

chmod 777 /data/data/com.termux/files/usr/tmp/.X11-unix


# 3. FIX AUDIO:
# Copy the PulseAudio cookie using root access
# to avoid Permission Denied errors
su -c "mkdir -p /mnt/Droidspaces/arkael/root/.config/pulse"

su -c "cp /data/data/com.termux/files/home/.config/pulse/cookie \
/mnt/Droidspaces/arkael/root/.config/pulse/cookie 2>/dev/null"

su -c "cp /data/data/com.termux/files/usr/etc/pulse/cookie \
/mnt/Droidspaces/arkael/root/.config/pulse/cookie 2>/dev/null"


# 4. Start Termux:X11 on display :5 silently
termux-x11 :5 -noreset >/dev/null 2>&1 &

sleep 5


# 5. Start the Droidspaces container
su -c "/data/local/Droidspaces/bin/droidspaces --name='arkael' start"

sleep 3


# 6. Add the required commands to the container's .bashrc
# Includes DBus, zombie-process cleanup, XFCE cleanup,
# and GPU acceleration configuration
su -c "echo 'export DISPLAY=:5; \
export XDG_RUNTIME_DIR=/run/user/0; \
mkdir -p \$XDG_RUNTIME_DIR; \
chmod 700 \$XDG_RUNTIME_DIR; \
export NO_AT_BRIDGE=1; \
export GALLIUM_DRIVER=virpipe; \
pkill -9 pulseaudio 2>/dev/null; \
pkill -9 -f xfce 2>/dev/null; \
pkill -9 xfwm4 xfdesktop xfce4-panel xscreensaver 2>/dev/null; \
sleep 1; \
rm -rf /tmp/.Xauthority; \
dbus-launch startxfce4; \
sed -i \"/startxfce4/d\" /root/.bashrc' \
>> /mnt/Droidspaces/arkael/root/.bashrc"


# 7. Enter the container
# GUI, audio, and GPU fixes will run automatically
su -c "/data/local/Droidspaces/bin/droidspaces --name='arkael' enter"
