#!/bin/bash

# Verificando se o usuário deseja congelar ou derreter os pacotes
if dialog --title "Congelar / Derreter Pacotes" --backtitle "$BACKTITLE" --yes-label "$1" --no-label "Cancelar" --yesno "\nDeseja congelar ou derreter os pacotes do Armbian?" 7 54; then
    # Conferindo se o gerenciador de pacotes está em execução
    if ! is_package_manager_running; then
        # Executando as ações conforme descrito no script
        TARGET_BRANCH=$BRANCH
        exceptions "$BRANCH"
        unset PACKAGE_LIST
        
        # Pacotes básicos
        check_if_installed linux-u-boot-${BOARD}-${UBOOT_BRANCH} && PACKAGE_LIST=$PACKAGE_LIST" linux-u-boot-${BOARD}-${UBOOT_BRANCH}"
        check_if_installed linux-image${TARGET_BRANCH}-${TARGET_FAMILY} && PACKAGE_LIST=$PACKAGE_LIST" linux-image${TARGET_BRANCH}-${TARGET_FAMILY}"
        check_if_installed linux-dtb$TARGET_BRANCH-$TARGET_FAMILY && PACKAGE_LIST=$PACKAGE_LIST" linux-dtb$TARGET_BRANCH-$TARGET_FAMILY"
        
        # Pacotes antigos do BSP
        check_if_installed linux-$(lsb_release -cs)-root$TARGET_BRANCH-$BOARD && PACKAGE_LIST=$PACKAGE_LIST" linux-$(lsb_release -cs)-root$TARGET_BRANCH-$BOARD"
        check_if_installed linux-headers${TARGET_BRANCH}-${TARGET_FAMILY} && PACKAGE_LIST=$PACKAGE_LIST" linux-headers${TARGET_BRANCH}-${TARGET_FAMILY}"
        
        # Pacotes novos do BSP
        check_if_installed armbian-${LINUXFAMILY} && PACKAGE_LIST=$PACKAGE_LIST" armbian-${LINUXFAMILY}"
        check_if_installed armbian-${BOARD} && PACKAGE_LIST=$PACKAGE_LIST" armbian-${BOARD}"
        check_if_installed armbian-$(lsb_release -cs) && PACKAGE_LIST=$PACKAGE_LIST" armbian-$(lsb_release -cs)"
        check_if_installed armbian-$(lsb_release -cs)-desktop-xfce && PACKAGE_LIST=$PACKAGE_LIST" armbian-$(lsb_release -cs)-desktop-xfce"
        check_if_installed armbian-firmware && PACKAGE_LIST=$PACKAGE_LIST" armbian-firmware"
        check_if_installed armbian-firmware-full && PACKAGE_LIST=$PACKAGE_LIST" armbian-firmware-full"
        
        local words=( $PACKAGE_LIST )
        local command="unhold"
        IFS=" "
        [[ $1 == "Freeze" ]] && local command="hold"
        for word in $PACKAGE_LIST; do apt-mark $command $word; done | dialog --backtitle "$BACKTITLE" --title "Pacotes ${1,,}" --progressbox $((${#words[@]}+2)) 64
    fi
else
    # Cancelar a operação
    echo "Operação cancelada pelo usuário."
fi

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
