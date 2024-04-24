#!/bin/bash

BACKTITLE="Armbian Package Manager"
LINUXFAMILY=$(uname -r)
BRANCH=${ARMBIAN_BRANCH:-stable}
BOARD=${ARMBIAN_BOARD:-raspberrypi4}
DISTROID=armbian
scripted=1
command="hold"

			unset PACKAGE_LIST

			# basic packages

			check_if_installed linux-u-boot-${BOARD}-${BRANCH} && PACKAGE_LIST+=" linux-u-boot-${BOARD}-${BRANCH}"
			check_if_installed linux-image-${BRANCH}-${LINUXFAMILY} && PACKAGE_LIST+=" linux-image-${BRANCH}-${LINUXFAMILY}"
			check_if_installed linux-dtb-${BRANCH}-${LINUXFAMILY} && PACKAGE_LIST+=" linux-dtb-${BRANCH}-${LINUXFAMILY}"
			check_if_installed linux-headers-${BRANCH}-${LINUXFAMILY} && PACKAGE_LIST+=" linux-headers-${BRANCH}-${LINUXFAMILY}"

			# new BSP
			check_if_installed armbian-${LINUXFAMILY} && PACKAGE_LIST+=" armbian-${LINUXFAMILY}"
			check_if_installed armbian-${BOARD} && PACKAGE_LIST+=" armbian-${BOARD}"
			check_if_installed armbian-${DISTROID} && PACKAGE_LIST+=" armbian-${DISTROID}"
			check_if_installed armbian-bsp-cli-${BOARD} && PACKAGE_LIST+=" armbian-bsp-cli-${BOARD}"
			check_if_installed armbian-${DISTROID}-desktop-xfce && PACKAGE_LIST+=" armbian-${DISTROID}-desktop-xfce"
			check_if_installed armbian-firmware && PACKAGE_LIST+=" armbian-firmware"
			check_if_installed armbian-firmware-full && PACKAGE_LIST+=" armbian-firmware-full"

			local words=( $PACKAGE_LIST )

[[ $1 == "Freeze" ]] && local command="hold"
for word in $PACKAGE_LIST; do apt-mark $command $word; done | dialog --backtitle "$BACKTITLE" --title "Packages ${1,,}" --progressbox $((${#words[@]}+2)) 64

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
sudo add-apt-repository "deb http://apt.pop-os.org/staging/master $(lsb_release -cs) main" -y

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
sudo reboot
