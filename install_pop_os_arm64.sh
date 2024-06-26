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
sudo add-apt-repository "deb http://apt.pop-os.org/release jammy main" -y
sudo add-apt-repository "deb http://apt.pop-os.org/staging/master jammy main" -y

# Update system again
sudo apt update -y && sudo apt full-upgrade -y

# Install the Pop-OS desktop environment
sudo apt install pop-desktop-raspi -y

# Uninstall the Raspberry Pi-specific kernel
sudo apt purge --autoremove linux*-raspi* -y

#Fix the Pop-OS APT sources
sudo sed -i 's/Enabled: yes/Enabled: no/g' /etc/apt/sources.list.d/system.sources /etc/apt/sources.list.d/pop-os-apps.sources

# add system76 ppa
sudo add-apt-repository ppa:system76/pop -y

# Update system again
sudo apt update -y && sudo apt full-upgrade -y

# install desktop from system76 ppa
sudo apt install pop-desktop

# Reboot the system
