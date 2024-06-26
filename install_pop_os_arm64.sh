#!/bin/bash

# Update system
sudo apt update -y && sudo apt full-upgrade -y

# Remove unnecessary Ubuntu Desktop-specific packages
sudo apt-get remove ubuntu-gnome-desktop -y
sudo apt-get remove gnome-shell -y
sudo apt-get remove --auto-remove ubuntu-gnome-desktop -y
sudo apt-get purge ubuntu-gnome-desktop -y
sudo apt-get purge --auto-remove ubuntu-gnome-desktop -y
sudo apt-get autoremove -y
sudo dpkg-reconfigure gdm -y
sudo apt-get remove gdm -y
sudo apt purge --autoremove ubuntu-desktop -y

# Add the Pop OS ISO signing key
sudo gpg --keyserver keyserver.ubuntu.com --recv-keys 63C46DF0140D738961429F4E204DD8AEC33A7AFF
sudo gpg --export 63C46DF0140D738961429F4E204DD8AEC33A7AFF > pop_os.gpg
sudo mv pop_os.gpg /etc/apt/trusted.gpg.d/
sudo chown root:root /etc/apt/trusted.gpg.d/pop_os.gpg
sudo chmod 644 /etc/apt/trusted.gpg.d/pop_os.gpg

# Add the Pop OS APT repositories
sudo add-apt-repository "deb http://apt.pop-os.org/release $(lsb_release -cs) main" -y
sudo add-apt-repository "deb http://apt.pop-os.org/proprietary $(lsb_release -cs) main" -y

# Update system again
sudo apt update -y && sudo apt full-upgrade -y

# Install the Pop-OS desktop environment
sudo apt install pop-desktop-raspi -y

# Uninstall the Raspberry Pi-specific kernel
sudo apt purge --autoremove linux*-raspi* -y

#Fix the Pop-OS APT sources
sudo sed -i 's/Enabled: yes/Enabled: no/g' /etc/apt/sources.list.d/system.sources /etc/apt/sources.list.d/pop-os-apps.sources

sudo apt-get install libdrm-nouveau2 libdrm-radeon1 libdrm2 libdrm-nouveau2 libdrm-radeon1 libdrm2 libdrm2 -y
# install desktop from system76 ppa
sudo apt install pop-desktop -y
sudo mv /boot/initrd.img initrd.img.bkp
sudo mv /boot/initrd.img.old initrd.img
sudo mv /boot/vmlinuz /boot/vmlinuz.bkp
sudo mv /boot/vmlinuz.old /boot/vmlinuz
sudo mv /boot/uInitrd /boot/uInitrd.bkp
sudo ln -s /boot/uInitrd-$(uname -r) /boot/uInitrd

sudo apt install glmark2-es2-wayland -y
# glmark2-es2-wayland

# Edit the file /etc/gdm3/custom.conf 
# WaylandEnable=true 

sudo sed -i 's/WaylandEnable=false/WaylandEnable=true/' /etc/gdm3/custom.conf

sudo sed -i 's/exit 0$/echo dec > \/dev\/video-dec0\nchown root:video \/dev\/video-dec0\nchmod 0660 \/dev\/video-dec0\necho enc > \/dev\/video-enc0\nchown root:video \/dev\/video-enc0\nchmod 0660 \/dev\/video-enc0\nexit 0/g' /etc/rc.local

echo -e "# Add multimedia group permissions\n" > /etc/udev/rules.d/11-rockchip-multimedia.rules
echo -e "KERNEL==\"mpp_service\", MODE=\"0660\", GROUP=\"video\"\n" >> /etc/udev/rules.d/11-rockchip-multimedia.rules
echo -e "KERNEL==\"rga\", MODE=\"0660\", GROUP=\"video\"\n" >> /etc/udev/rules.d/11-rockchip-multimedia.rules
echo -e "KERNEL==\"system-dma32\", MODE=\"0666\", GROUP=\"video\"\n" >> /etc/udev/rules.d/11-rockchip-multimedia.rules
echo -e "KERNEL==\"system-uncached-dma32\", MODE=\"0666\", GROUP=\"video\"RUN+=\"/usr/bin/chmod a+rw /dev/dma_heap\"\n" >> /etc/udev/rules.d/11-rockchip-multimedia.rules


# remove inconpatible repos
sudo add-apt-repository --remove http://apt.pop-os.org/proprietary -y      
sudo add-apt-repository --remove http://apt.pop-os.org/release -y

# Reboot the system
sudo reboot
