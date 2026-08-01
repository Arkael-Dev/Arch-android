#!/bin/sh

# ============================================================
# Droidspaces + Termux:X11 + PulseAudio + gnome Setup
# Container: ark
# Display: :5
# ============================================================

# 1. Force-stop Termux:X11 app, stop container, and kill processes
su -c "am force-stop com.termux.x11" 2>/dev/null
su -c "/data/local/Droidspaces/bin/droidspaces --name='ark' stop" 2>/dev/null

pkill -9 -f termux-x11 2>/dev/null
su -c "pkill -9 -f termux-x11" 2>/dev/null
su -c "killall -9 termux-x11 Xorg virglrenderer pulseaudio 2>/dev/null"

sleep 3

# 2. Clean old X11 lock files and sockets (Hapus total folder socketnya)
su -c "rm -rf /data/data/com.termux/files/usr/tmp/.X5-lock /data/data/com.termux/files/usr/tmp/.X11-unix"
rm -rf /data/data/com.termux/files/usr/tmp/.X5-lock /data/data/com.termux/files/usr/tmp/.X11-unix

mkdir -p /data/data/com.termux/files/usr/tmp/.X11-unix
chmod 777 /data/data/com.termux/files/usr/tmp/.X11-unix

# 3. FIX AUDIO: Copy PulseAudio cookie
su -c "mkdir -p /mnt/Droidspaces/ark/root/.config/pulse"
su -c "cp -f /data/data/com.termux/files/home/.config/pulse/cookie /mnt/Droidspaces/ark/root/.config/pulse/cookie 2>/dev/null"
su -c "cp -f /data/data/com.termux/files/usr/etc/pulse/cookie /mnt/Droidspaces/ark/root/.config/pulse/cookie 2>/dev/null"

# 4. Start Termux:X11 on display :5 (Output tidak disembunyikan agar bisa terlihat jika error)
termux-x11 :5 -noreset &
sleep 5

# 5. Start the Droidspaces container
su -c "/data/local/Droidspaces/bin/droidspaces --name='ark' start"
sleep 3

# 6. Add the required commands to the container's .bashrc
# Mengembalikan llvmpipe karena VirGL crash (lost connection to rendering server)
su -c "echo 'apt update && apt install -y dbus-x11 gnome-shell; \
export DISPLAY=:5; \
export XDG_RUNTIME_DIR=/run/user/0; \
mkdir -p \$XDG_RUNTIME_DIR; \
chmod 700 \$XDG_RUNTIME_DIR; \
export NO_AT_BRIDGE=1; \
export XDG_CURRENT_DESKTOP=GNOME; \
export XDG_SESSION_TYPE=x11; \
export GALLIUM_DRIVER=llvmpipe; \
export LIBGL_ALWAYS_SOFTWARE=1; \
pkill -9 pulseaudio 2>/dev/null; \
pkill -9 -f gnome 2>/dev/null; \
pkill -9 gnome-shell gnome-session gsd-* 2>/dev/null; \
sleep 1; \
rm -rf /tmp/.Xauthority; \
dbus-launch gnome-shell --x11; \
sed -i \"/gnome-shell/d\" /root/.bashrc' \
>> /mnt/Droidspaces/ark/root/.bashrc"

# 7. Enter the container
su -c "/data/local/Droidspaces/bin/droidspaces --name='ark' enter"
