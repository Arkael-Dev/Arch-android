#!/data/data/com.termux/files/usr/bin/bash
pkg update -y
pkg upgrade -y

# Repo & paket dasar
pkg install tur-repo -y
pkg install x11-repo -y
pkg install termux-x11-nightly pulseaudio wget git proot-distro -y
termux-setup-storage

# Pasang Arch Linux ARM
proot-distro install danhunsaker/archlinuxarm:20260726

# Konfigurasi sistem dalam Arch
proot-distro login archlinuxarm -- bash -c "
sed -i 's/^#DownloadUser = alpm/DownloadUser = alpm/' /etc/pacman.conf
mv /usr/bin/pacman /usr/bin/pacman-real
cat > /usr/bin/pacman <<'INNER'
#!/bin/bash
/usr/bin/pacman-real --disable-sandbox \"\$@\"
INNER
chmod +x /usr/bin/pacman
pacman -Sy --noconfirm
pacman -Syu --noconfirm
pacman -S --needed --noconfirm xfce4 xfce4-goodies sudo
useradd -m -G wheel Arkael
echo 'Arkael:1234' | chpasswd
sed -i '/^root ALL=(ALL:ALL) ALL$/a Arkael ALL=(ALL:ALL) ALL' /etc/sudoers
"

# Unduh & ubah skrip peluncur otomatis
wget -q -O ~/start_arch.sh https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/refs/heads/main/scripts/proot_arch/startxfce4_arch.sh
sed -i 's/droidmaster/Arkael/g; s/proot-distro login archlinux/proot-distro login archlinuxarm/g' ~/start_arch.sh

# Tambah pengaturan tampilan & suara
cat >> ~/start_arch.sh << 'EOF'
export DISPLAY=:0
export PULSE_SERVER=127.0.0.1
xrdb -merge <<< "Xft.dpi: 144"
export GDK_SCALE=2
export GDK_DPI_SCALE=0.75
export XCURSOR_SIZE=40
export QTWEBENGINE_DISABLE_GPU=1
export QT_QUICK_BACKEND=software
EOF

# Beri izin & tambah perintah singkat
chmod +x ~/start_arch.sh
grep -q "alias arkael-arch=" ~/.bashrc || echo "alias arkael-arch='bash ~/start_arch.sh'" >> ~/.bashrc
source ~/.bashrc

# Jalankan
arkael-arch
